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

fn part2(input: &Vec<Vec<u32>>) {
    let mut total: u64 = 0;
    let mut counter = 1;

    for bank in input {
        let mut bats: Vec<u32> = Vec::with_capacity(12);
        bats.extend_from_slice(&bank[..12]);
        let mut cur = 0;

        for (i, it) in bank.iter().enumerate() {
            let end = i + 12 - cur;

            // copy everything after this value
            if *it > bats[cur] {
                bats[cur..].clone_from_slice(&bank[i..end]);
            }

            // advance cur if there aren't enough numbers left
            if end > bank.len() - 1 {
                cur = cur + 1;
            }
        }

        // 166003625787367 is too low

        // compose it into a number
        let mut jolt: u64  = 0;
        for place in 0..12 {
            jolt += bats[12 - place - 1] as u64 * 10u64.pow(place as u32);
        }

        println!("Found {} on line {}", jolt, counter);
        counter += 1;
        total += jolt as u64;
    }
    println!("Total: {}", total);
}

pub fn solve(sample: bool) {
    let mut filename = "data/day3/input.txt";
    if sample {
        filename = "data/day3/sample.txt";
    }

    let input = load(filename);

    print!("Part 1: ");
    part1(&input);
    print!("Part 2: ");
    part2(&input);
}
