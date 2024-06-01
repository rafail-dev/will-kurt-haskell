module Main (main) where

import qualified Data.ByteString.Lazy as BL
import Lib (Method (..), buildRequest)
import Network.HTTP.Simple (getResponseBody, getResponseStatus, getResponseStatusCode, httpLBS)
import Network.HTTP.Types.Status (statusMessage)

main :: IO ()
main = do
  response <- httpLBS (buildRequest GET "www.ncdc.noaa.gov" "/cdo-web/api/v2/datasets" "<TOKEN from https://github.com/NOAAGov>")
  let statusCode = getResponseStatusCode response
  let jsonBody = getResponseBody response
  if statusCode == 200
    then do
      putStrLn "Результаты запроса были сохранены в файл"
      BL.writeFile "data.json" jsonBody
    else do
      -- print $ statusMessage $ getResponseStatus response -- statusMessage is " "
      print jsonBody -- error message is here
      print statusCode
      putStrLn "Запрос не удалось совершить из-за ошибки"
