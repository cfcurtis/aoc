module Test.Day06 (tests) where

import Common
import Day06 (part1, part2)

input :: String
input = ["mjqjpqmgbljsphdztnvjfqwrcgsmlb",
          "bvwbjplbgvbhsrlpgdmjqwftvncz",
          "nppdvjthqldpwncqszvftbrmjlhg",
          "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg",
          "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw"] !! 1

expected1 :: String
expected1 = ["7","5","6","10","11"] !! 1
expected2 :: String
expected2 = "23"

tests =
  createTests
    [ TestResult "Day 06 - Part 1" expected1 (show $ part1 input),
      TestResult "Day 06 - Part 2" expected2 (show $ part2 input)
    ]