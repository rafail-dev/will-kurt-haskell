{-# LANGUAGE OverloadedStrings #-}

module Marc where

import Book (Author, Title)
import Consts
import Data.ByteString qualified as B
import Data.List qualified as L
import Data.Maybe (catMaybes)
import Data.Text qualified as T
import Data.Text.Encoding qualified as E
import Text.Read (readMaybe)

type MarcRecordRaw = B.ByteString

type MarcLeaderRaw = B.ByteString

type MarcDirectoryRaw = B.ByteString

type MarcDirectoryEntryRaw = B.ByteString

data FieldMetadata = FieldMetadata
  { tag :: T.Text,
    fieldLength :: Int,
    fieldStart :: Int
  }
  deriving (Show)

type FieldText = T.Text

maybeDecodeUtf8 :: B.ByteString -> Maybe T.Text
maybeDecodeUtf8 bs = case E.decodeUtf8' bs of
  Right text -> Just $ text
  Left _ -> Nothing

maybeRawToInt :: B.ByteString -> Maybe Int
maybeRawToInt bs = maybeDecodeUtf8 bs >>= readMaybe . T.unpack

getLeader :: MarcRecordRaw -> MarcLeaderRaw
getLeader = B.take leaderLength

getRecordLength :: MarcLeaderRaw -> Maybe Int
getRecordLength = maybeRawToInt . B.take lengthLength

getBaseAddress :: MarcLeaderRaw -> Maybe Int
getBaseAddress = maybeRawToInt . (B.take lengthLength) . (B.drop directoryEntryLength)

getDirectoryLength :: MarcLeaderRaw -> Maybe Int
getDirectoryLength = fmap ((negate leaderLength - 1) +) . getBaseAddress

getDirectory :: B.ByteString -> Maybe MarcDirectoryRaw
getDirectory record =
  case getDirectoryLength record of
    Just length -> Just $ B.take length (B.drop leaderLength record)
    _ -> Nothing

--

splitDirectory :: MarcDirectoryRaw -> [MarcDirectoryEntryRaw]
splitDirectory directory = if directory == B.empty then [] else next : splitDirectory rest
  where
    (next, rest) = B.splitAt directoryEntryLength directory

getFieldMetadata :: [MarcDirectoryEntryRaw] -> [Maybe FieldMetadata]
getFieldMetadata entries = map entryToFieldMetadata entries
  where
    entryToFieldMetadata :: MarcDirectoryEntryRaw -> Maybe FieldMetadata
    entryToFieldMetadata entry = do
      length <- maybeRawToInt rawLength
      start <- maybeRawToInt rawStart
      decodedTag <- maybeDecodeUtf8 tag
      Just $ FieldMetadata decodedTag length start
      where
        (tag, rest) = B.splitAt 3 entry
        (rawLength, rawStart) = B.splitAt 4 rest

getTextField :: MarcRecordRaw -> FieldMetadata -> Maybe FieldText
getTextField record fieldMetaData = fieldAsBytes >>= Just . E.decodeUtf8
  where
    baseRecord = getBaseAddress record >>= Just . (flip B.drop) record
    baseAtEntry = baseRecord >>= Just . B.drop (fieldStart fieldMetaData)
    fieldAsBytes = baseAtEntry >>= Just . B.take (fieldLength fieldMetaData)

--

lookupFieldMetadata :: T.Text -> MarcRecordRaw -> Maybe FieldMetadata
lookupFieldMetadata aTag record = fields >>= L.uncons >>= Just . fst
  where
    metadata = getDirectory record >>= Just . getFieldMetadata . splitDirectory >>= Just . catMaybes
    fields = metadata >>= Just . filter ((== aTag) . tag)

lookupSubfield :: (Maybe FieldMetadata) -> Char -> MarcRecordRaw -> Maybe T.Text
lookupSubfield Nothing _ _ = Nothing
lookupSubfield (Just fieldMetadata) subfield record = maybeResult
  where
    rawField = getTextField record fieldMetadata
    subFields = rawField >>= Just . T.split (== fieldDelimiter)
    maybeResults =
      subFields
        >>= Just
          . map snd
          . filter ((subfield ==) . fst)
          . catMaybes
          . map (\v -> T.uncons v)
    maybeResult = maybeResults >>= (\v -> L.uncons v) >>= Just . fst

lookupValue :: T.Text -> Char -> MarcRecordRaw -> Maybe T.Text
lookupValue aTag subField record = lookupSubfield (lookupFieldMetadata aTag record) subField record

lookupTitle :: MarcRecordRaw -> Maybe Title
lookupTitle record = result mainTitle additionalTitle
  where
    mainTitle = lookupValue titleTag titleSubfield record
    additionalTitle = lookupValue titleTag additionalTitleSubfield record
    result (Just p1) (Just p2) = Just $ mconcat [p1, p2]
    result (Just p1) Nothing = Just p1
    result _ _ = Nothing

lookupAuthor :: MarcRecordRaw -> Maybe Author
lookupAuthor = lookupValue authorTag authorSubfield

--
nextAndRest :: B.ByteString -> Maybe (MarcRecordRaw, B.ByteString)
nextAndRest stream = getRecordLength stream >>= Just . flip B.splitAt stream

toRecords :: B.ByteString -> [MarcRecordRaw]
toRecords bs = do
  let r = nextAndRest bs
  case (nextAndRest bs) of
    Just (next, rest) -> next : toRecords rest
    _ -> []

parseRecord :: MarcRecordRaw -> (Maybe Author, Maybe Title, MarcRecordRaw)
parseRecord bs = (author, title, bs)
  where
    author = lookupAuthor bs
    title = lookupTitle bs