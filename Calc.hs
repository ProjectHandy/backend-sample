import Data.List
import System.Environment

coins :: [Int]
coins = [10000, 5000, 2000, 1000, 500, 100, 25, 10, 5, 1]

names :: [String]
names = ["100", "50", "20", "10", "5", "1", ".25", ".10", ".05", "0.01"]

calcRec :: Int -> [Int] -> [Int]
calcRec val [] = []
calcRec val (coin:coins) = div val coin: calcRec (mod val coin) coins

calc :: Int -> [Int]
calc = flip calcRec coins

showEntry :: Int -> String -> String
showEntry 0 _ = ""
showEntry val name = show name ++ ":" ++ show val

showEntries :: [Int] -> [String]
showEntries vals = filter  (/="") (zipWith showEntry vals names)

toJson :: [Int] -> String
toJson x = "{" ++ intercalate "," (showEntries x) ++ "}"

changeCore :: Int -> String
changeCore = toJson . calc

change :: String -> String
change ('-':ss) = show "You owe me money buddy" ++ "\n"
change s = changeCore (round (((read ("0" ++ s)) :: Double) * 100)) ++ "\n"

main :: IO ()
main = do 
     x <- getArgs
     case x of
     	  (a:as) -> putStrLn (change a)
	  [] 	 -> putStrLn "Usage: one argument."