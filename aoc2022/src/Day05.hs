module Day05 (solve) where
import Data.List.Split (splitOn)
import Data.Char (isDigit, isSpace, digitToInt, isAlpha)
import Data.List (transpose)
import Debug.Trace (trace)

-- Parses the crate stack from the input
readCrates :: String -> [String]
readCrates contents =
    map (init . dropWhile isSpace) -- get rid of the leading space and crate numbering
    $ filter (isDigit . last) $ transpose -- transpose to get the crates in columns
    $ lines . head $ splitOn "\n\n" contents -- split the crate definition from instructions

-- Parses the instructions from the input
readInstructions :: String -> [[Int]]
readInstructions contents =
    [map read . words $ filter (not . isAlpha) line | -- drop the text from the instructions
    line <- lines $ last $ splitOn "\n\n" contents] -- split the crate definition from instructions

-- manipulate the crates
modStack :: [Char] -> Int -> Int -> (Int, String) -> String
modStack crate from to (index, stack)
    | null crate = stack -- Don't drop an empty crate
    | index == from = drop (length crate) stack -- drop the crate(s) from the stack if the current index is the from index
    | index == to = crate ++ stack -- push the crate onto the stack if the current index is the to index
    | otherwise = stack -- otherwise, leave the stack unchanged

-- move crates according to the instructions
moveCrate :: [String] -> [Int] -> [String]
moveCrate crates (num:from:to:rest)
    | num == 0 = crates
    | num == 1 = zipWith (curry (modStack crate from to)) [1..(length crates)] crates
    | from == to = crates
    | otherwise = moveCrate (moveCrate crates [1, from, to]) [num - 1, from, to]
        where crate = take 1 $ crates !! (from - 1)
moveCrate _ _ = []

-- move stacks of crates according to the instructions
moveStacks :: [String] -> [Int] -> [String]
moveStacks crates (num:from:to:rest)
    | from == to = crates
    | otherwise = zipWith (curry (modStack crate from to)) [1..(length crates)] crates
        where crate = take num $ crates !! (from - 1)
moveStacks _ _ = []

-- Which crates are on top of the stacks?
part1 :: String -> String
part1 contents = map head $ foldl moveCrate (readCrates contents) (readInstructions contents)

-- Which crates are on top of the stacks when multiples move at once?
part2 :: String -> String
part2 contents = map head $ foldl moveStacks (readCrates contents) (readInstructions contents)

solve :: String -> IO ()
solve contents = putStrLn "--- Day 05 ---" >>
    putStrLn (part1 contents) >> putStrLn (part2 contents)