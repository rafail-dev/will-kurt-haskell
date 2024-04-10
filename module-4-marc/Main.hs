import Book (Book, toBook)
import Data.ByteString qualified as B
import Data.Text.IO qualified as TIO
import Html (booksToHtml)
import Marc (MarcRecordRaw, lookupAuthor, lookupTitle, parseRecord, toRecords)

marsToBooks :: MarcRecordRaw -> [Book]
marsToBooks stream = map toBook $ tuples
  where
    records = toRecords stream
    tuples = map parseRecord records

main :: IO ()
main = do
  stream <- B.readFile "sample.mrc" -- or https://archive.org/download/marc_oregon_summit_records/catalog_files/ohsu_ncnm_wscc_bibs.mrc
  let html = booksToHtml $ marsToBooks stream
  TIO.writeFile "result.html" html
