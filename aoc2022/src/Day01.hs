module Day01 (solve) where
import Data.List ( sort )
import Data.List.Split ( splitOn )

-- Adds up each grouping of calories separated by an extra newline
listify :: String -> [Int]
listify contents = [sum (map read x::[Int]) | x <-  map lines $ splitOn "\n\n" contents]

-- Max total calories
part1 :: String -> Int
part1 contents = maximum $ listify contents

-- Top sum of the top three total calories
part2 :: String -> Int
part2 contents = sum $ take 3 $ reverse $ sort $ listify contents

solve :: String -> IO ()
solve contents = putStrLn "--- Day 01 ---" >>
    print (part1 contents) >> print (part2 contents)