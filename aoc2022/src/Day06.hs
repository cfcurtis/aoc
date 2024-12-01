module Day06 (solve, part1, part2) where
import Data.List (nub)
import Debug.Trace (trace)

-- Check if the characters are all unique
isMarker :: String -> Bool
isMarker chunk = nub chunk == chunk

-- loop through the characters with a sliding window of size n
findMarker :: Int -> String -> Int
findMarker n xs
    | isMarker $ take n xs = n
    | otherwise = findMarker n (drop 1 xs) + 1

-- Find the first unique 4-character string
part1 :: String -> Int
part1 = findMarker 4

-- Find the first unique 14-character string
part2 :: String -> Int
part2 = findMarker 14

solve :: String -> IO ()
solve contents = putStrLn "--- Day 06 ---" >>
    print (part1 contents) >> print (part2 contents)