module Test.Day07 (tests) where

import Common
import Day07 (part1, part2)
import Text.Read.Lex (expect)
import Common (TestResult(TestResult))

input :: String
input = "$ cd /\n\
\$ ls\n\
\dir a\n\
\14848514 b.txt\n\
\8504156 c.dat\n\
\dir d\n\
\$ cd a\n\
\$ ls\n\
\dir e\n\
\29116 f\n\
\2557 g\n\
\62596 h.lst\n\
\$ cd e\n\
\$ ls\n\
\584 i\n\
\$ cd ..\n\
\$ cd ..\n\
\$ cd d\n\
\$ ls\n\
\4060174 j\n\
\8033020 d.log\n\
\5626152 d.ext\n\
\7214296 k"

expected1 :: String
expected1 = "95437"

tests = createTests 
    [
        TestResult "Day 07 - Part 1" expected1 (show $ part1 input)
    ]