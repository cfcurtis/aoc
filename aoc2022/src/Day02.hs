module Day02 (solve) where
import System.IO ()
import Data.List ()

-- Convert the characters into the score values
toScore :: Char -> Int
toScore 'X' = 1
toScore 'Y' = 2
toScore 'Z' = 3
toScore 'A' = 1
toScore 'B' = 2
toScore 'C' = 3
toScore _ = 0

-- Split each line into a list of ints
listify :: String -> [[Int]]
listify contents = map ((map toScore . concat) . words) (lines contents)

-- Bonus points for winning
winPoints :: [Int] -> Int
winPoints [a, b]
  | b - a == 1 || b - a == -2 = 6
  | b == a = 3
  | otherwise = 0
winPoints _ = 0

-- Part1
part1 :: [[Int]] -> Int
part1 choices = sum (map winPoints choices) + sum (map (!! 1) choices)

-- Convert the choice in the second column based on 1 = lose, 2 = draw, 3 = win
chooseShape :: [Int] -> [Int]
chooseShape [a, b]
  | b == 1 = [a, if a == 1 then 3 else a - 1] -- Lose: 1 -> 3, 2 -> 1, 3 -> 2
  | b == 2 = [a, a]
  | b == 3 = [a, if a == 3 then 1 else a + 1]
chooseShape _ = []

-- Part 2
part2 :: [[Int]] -> Int
part2 choices = part1 $ map chooseShape choices

solve :: String -> IO ()
solve contents = putStrLn "--- Day 02 ---" >>
    print (part1 $ listify contents) >> print (part2 $ listify contents)