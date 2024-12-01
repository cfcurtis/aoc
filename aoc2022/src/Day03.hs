module Day03 (solve) where
import Data.Char ( ord, isAsciiLower, isAsciiUpper )
import Data.List.Split ( chunksOf )

-- maps the character to the priority
priority :: Char -> Int
priority c
    | isAsciiLower c = ord c - ord 'a' + 1
    | isAsciiUpper c = ord c - ord 'A' + 27
    | otherwise = 0

-- Finds the common element in the lists
commonElem :: [String] -> Char
commonElem [a, b] = head [x | x <- a, x `elem` b]
commonElem [a, b, c] = head [x | x <- a, x `elem` b && x `elem` c]
commonElem _ = '_'

-- Splits the rucksack into compartments
splitRucksack :: String -> (String, String)
splitRucksack rucksack = splitAt (length rucksack `div` 2) rucksack

-- Sum of priority of common elements
part1 :: String -> Int
part1 contents = sum $ [priority $ commonElem [fst rucksack, snd rucksack] | rucksack <- map splitRucksack $ lines contents]

-- Sum of priorities of common elements, this time across three rucksacks
part2 :: String -> Int
part2 contents = sum $ [priority $ commonElem elfGroup | elfGroup <- chunksOf 3 $ lines contents]

solve :: String -> IO ()
solve contents = putStrLn "--- Day 03 ---" >> 
    print (part1 contents) >> print (part2 contents)