module Day04 (solve) where
import Data.List.Split (splitOn)

-- Converts a string of the form "X-Y" into a list of corresponding integers
toRange :: String -> [Int]
toRange section = map read $ splitOn "-" section :: [Int]

-- Takes a pair of ranges and checks whether they fully contain the other
isContained :: [[Int]] -> Int
isContained [a, b]
    | head a >= head b && a !! 1 <= b !! 1 = 1
    | head b >= head a && b !! 1 <= a !! 1 = 1
    | otherwise = 0
isContained _ = 0

-- Takes a pair of ranges and checks whether there is any overlap
anyOverlap :: [[Int]] -> Int
anyOverlap [a, b]
    | head a <= b !! 1 && a !! 1 >= head b = 1
    | otherwise = 0
anyOverlap _ = 0

-- Apply either isContained or anyOverlap to the input
checkPairs :: ([[Int]] -> Int) -> String -> Int
checkPairs f contents = sum $ map ((f . map toRange) . splitOn ",") (lines contents)
-- Version before refactoring hints below
-- sum $ map f (map (map toRange) (map (splitOn ",") $ lines contents))

-- How many ranges fully contain the other in a given pair?
part1 :: String -> Int
part1 = checkPairs isContained

part2 :: String -> Int
part2 = checkPairs anyOverlap

solve :: String -> IO ()
solve contents = putStrLn "--- Day 04 ---" >>
    print (part1 contents) >> print (part2 contents)