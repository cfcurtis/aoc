module Day07 (solve, part1, part2) where
import Data.Char (isDigit)
import Data.List.Split (splitOn)
import Prelude hiding (lookup)
import qualified Data.Map as Map
import Data.Maybe ( fromMaybe )
import Data.IntMap (findWithDefault, singleton)
import Debug.Trace (trace)

data Directory = Directory {
    size :: Int, 
    parent :: String,
    subDirs :: [String]
    } deriving (Show, Eq)

type FileSystem = Map.Map String Directory

-- The root directory
root:: Directory
root = Directory {size=0, parent="/", subDirs=[]}

-- Update the size of the given directory
updateSize :: Int -> Directory -> Directory
updateSize addSize dir = dir {size = addSize + size dir}

-- Adds a subdir to the given directory if it doesn't already exist
addSubDir :: String -> Directory -> Directory
addSubDir subDir dir
    | elem subDir $ subDirs dir = dir
    | otherwise = dir {subDirs = subDir : subDirs dir}

-- Creates a new directory in the filesystem
mkdir :: FileSystem -> String -> String -> FileSystem
mkdir fs parent dirName = Map.insert dirName Directory {
    size = 0, 
    parent = parent, 
    subDirs = []
    } $ Map.adjust (addSubDir dirName) parent fs

-- Changes from the current directory to the given one, 
-- or creates it if not already in the filesystem
changeDir :: FileSystem -> String -> String -> (String, FileSystem)
changeDir fs currentDir toDir
    | toDir == ".." = (parent $ Map.findWithDefault root currentDir fs, fs)
    | elem toDir $ subDirs (Map.findWithDefault root currentDir fs) = (toDir, fs)
    | otherwise = (currentDir, fs) -- Can't change to this directory from here

-- parse the ls output
parseLs :: String -> (String, FileSystem) -> (String, FileSystem)
parseLs lsOutput (currentDir, fs) 
    | all isDigit firstArg = (currentDir, Map.adjust (updateSize (read firstArg :: Int)) currentDir fs)
    | firstArg == "dir" = (currentDir, Map.adjust (addSubDir (last $ words lsOutput)) currentDir fs)
    | otherwise = (currentDir, fs)
    where firstArg = head $ words lsOutput

-- Apply the given commands
applyCommands :: [String] -> (String, FileSystem) -> (String, FileSystem)
applyCommands (cmd:rest) (currentDir, fs)
    | take 4 cmd == "$ cd" = applyCommands rest (changeDir fs currentDir $ drop 5 cmd)
    | take 4 cmd == "$ ls" = applyCommands rest (currentDir, fs)
    | cmd == "" = ("/", fs) -- Reset the current directory at the last one
    | otherwise = applyCommands rest (parseLs cmd (currentDir, fs))
applyCommands [] (currentDir, fs) = (currentDir, fs)

-- Sum the subfolder sizes
sumDirSizes :: (String, FileSystem) -> [(String, Int)]


-- Placeholder for part 1
part1 :: String -> (String, FileSystem)
part1 contents = applyCommands (lines contents) ("/", Map.singleton "/" root)

-- Placeholder for part 2
part2 :: String -> Int
part2 contents = 0

solve :: String -> IO ()
solve contents = putStrLn "--- Day 07 ---" >>
    print (part1 contents) >> print (part2 contents)