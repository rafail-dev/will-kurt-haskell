{-# LANGUAGE InstanceSigs #-}

module Lib
  ( buildRequest,
    Method (GET, POST),
  )
where

import qualified Data.ByteString.Char8 as BC
import Network.HTTP.Simple
  ( Request,
    defaultRequest,
    setRequestHeader,
    setRequestHost,
    setRequestMethod,
    setRequestPath,
    setRequestPort,
    setRequestSecure,
  )

type Token = BC.ByteString

type Host = BC.ByteString

data Method = GET | POST deriving (Show, Eq)

type Path = BC.ByteString

class ToByteString a where
  toByteString :: a -> BC.ByteString

instance ToByteString Method where
  toByteString :: Method -> BC.ByteString
  toByteString GET = "GET"
  toByteString POST = "POST"

buildRequest :: Method -> Host -> Path -> Token -> Request
buildRequest method host path token =
  setRequestHeader "token" [token] $
    setRequestPath path $
      setRequestHost host $
        setRequestMethod (toByteString method) $
          setRequestPort 443 $
            setRequestSecure
              True
              defaultRequest
