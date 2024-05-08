import Control.Arrow
import Data.Map qualified as Map

type Degrees = Double

type Latitude = Degrees

type Longitude = Degrees

type LatLong = (Latitude, Longitude)

type Radian = Double

type Km = Double

toRadians :: Degrees -> Radian
toRadians v = v * pi / 180

locationDB :: Map.Map String LatLong
locationDB =
  Map.fromList
    [ ("Arkham", (42.6054, -70.7829)),
      ("Innsmouth", (42.8250, -70.8150)),
      ("Carcosa", (29.9714, -90.7694)),
      ("New York", (40.7776, -73.9691))
    ]

latLongToRadians :: LatLong -> (Radian, Radian)
-- latLongToRadians (lat, long) = (toRadians lat, toRadians long)
latLongToRadians = toRadians *** toRadians

haversine :: LatLong -> LatLong -> Km
haversine v1 v2 = earthRadius * c
  where
    earthRadius = 6378.1
    (lat1r, lon1r) = latLongToRadians v1
    (lat2r, lon2r) = latLongToRadians v2
    dLat = lat1r - lat2r
    dLon = lon1r - lon2r
    a = (sin (dLat / 2)) ^ 2 + cos lat1r * cos lat2r * (sin (dLon / 2)) ^ 2
    c = 2 * atan2 (sqrt a) (sqrt (1 - a))

find :: String -> Maybe LatLong
find = flip Map.lookup locationDB

main :: IO ()
main = do
  print "First City"
  name1 <- getLine
  print "Second City"
  name2 <- getLine

  case (haversine <$> find name1 <*> find name2) of
    (Just result) -> print result 
    _ -> print "Not Found"