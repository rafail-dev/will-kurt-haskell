# http-request

GHCi> import Network.HTTP.Simple
GHCi> response = httpLBS "http://news.ycombinator.com"
GHCi> getResponseHeader <$> response
Второй метод:
GHCi> response <- httpLBS "http://news.ycombinator.com"
GHCi> getResponseHeader response
