use std::error::Error;
use std::fs;

fn load(filename: &str) -> Vec<Vec<u32>> {
    fs::read_to_string(filename)
        .expect("Could not open file")
        .lines()
        .map(|s| s.chars().filter_map(|c| c.to_digit(10)).collect::<Vec<u32>>())
        .collect::<Vec<Vec<u32>>>()
}

fn part1(input: &Vec<Vec<u32>>) {
    let mut total = 0;
    let mut counter = 1;
    for bank in input {
        let mut tens = *bank.first().unwrap();
        let mut ones = 0;

        for it in bank[1..bank.len() - 1].iter() {
            // update the second number if it's bigger
            if *it > ones {
                ones = *it;
            }

            // if we've found a new max tens number, update and set ones to 0
            // skip if it's the last one
            if *it > tens {
                tens = *it;
                ones = 0;
            }
        }

        // check the last one
        if *bank.last().unwrap() > ones {
            ones = *bank.last().unwrap();
        }

        let jolt = tens * 10 + ones;
        println!("Found {} on line {}", jolt, counter);
        counter += 1;
        total += jolt;
    }
    println!("Total: {}", total);
}

fn part2(input: &Vec<Vec<u32>>) {}

pub fn solve(sample: bool) {
    let mut filename = "data/day3/input.txt";
    if sample {
        filename = "data/day3/sample.txt";
    }

    let input = load(filename);

    print!("Part 1: ");
    part1(&input);
    // print!("Part 2: ");
    // part2(&input);
}
