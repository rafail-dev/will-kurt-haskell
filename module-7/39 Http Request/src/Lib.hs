{-# LANGUAGE InstanceSigs #-}

module Lib
  ( buildRequest,
    buildRequestNOSSL,
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

buildRequestBase :: Method -> Host -> Path -> Token -> Request
buildRequestBase method host path token =
  setRequestHeader "token" [token] $
    setRequestPath path $
      setRequestHost host $
        setRequestMethod (toByteString method) defaultRequest

buildRequest :: Method -> Host -> Path -> Token -> Request
buildRequest method host path token =
  setRequestPort 443 $
    setRequestSecure True $
      buildRequestBase method host path token

buildRequestNOSSL :: Method -> Host -> Path -> Token -> Request
buildRequestNOSSL method host path token =
  setRequestPort 80 $
    setRequestSecure False $
      buildRequestBase method host path token
