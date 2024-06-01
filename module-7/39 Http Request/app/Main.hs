module Main (main) where

import qualified Data.ByteString.Lazy as BL
import Lib (Method (..), buildRequest)
import Network.HTTP.Simple (getResponseBody, getResponseStatusCode, httpLBS)

main :: IO ()
main = do
  response <- httpLBS (buildRequest GET "www.ncdc.noaa.gov" "/cdo-web/api/v2/datasets" "<TOKEN from https://github.com/NOAAGov>")

  if getResponseStatusCode response == 200
    then do
      putStrLn "Результаты запроса были сохранены в файл"
      let jsonBody = getResponseBody response
      BL.writeFile "data.json" jsonBody
    else
      putStrLn "Запрос не удалось совершить из-за ошибки"
