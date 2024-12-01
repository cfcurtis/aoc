import Data.Foldable (null)
import Data.Map (Map)
import qualified Data.Map as M
import Data.Maybe (mapMaybe)
import System.Environment
import qualified Test.Day06 (tests)
import qualified Test.Day07 (tests)
import Test.HUnit

testcases :: Map String Test
testcases =
  M.fromList
    [ ("06", Test.Day06.tests),
      ("07", Test.Day07.tests)
    ]

gather :: [String] -> [Test]
gather ks
  | any (`M.notMember` testcases) ks = error "request test cases not implemented"
  | otherwise = mapMaybe (`M.lookup` testcases) ks

main :: IO ()
main = do
  args <- getArgs
  if null args
    then runTestTTAndExit (TestList $ gather (M.keys testcases))
    else runTestTTAndExit (TestList $ gather args)