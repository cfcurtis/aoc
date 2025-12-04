use std::fs;

fn load(filename: &str) -> Vec<Vec<u32>> {
    fs::read_to_string(filename)
        .expect("Could not open file")
        .lines()
        .map(|s| {
            s.chars()
                .filter_map(|c| c.to_digit(10))
                .collect::<Vec<u32>>()
        })
        .collect::<Vec<Vec<u32>>>()
}

fn max_jolt(bank: &Vec<u32>, n: usize) -> u64 {
    let mut bats: Vec<u32> = vec![0; n];
    let mut cur_highest = 0;

    for (i, it) in bank.iter().enumerate() {
        // loop through all the values
        for idx in cur_highest..n {
            if *it > bats[idx] {
                bats[idx] = *it;
                // obliterate the rest
                for ii in idx+1..n {
                    bats[ii] = 0;
                }
                break;
            }
        }

        // advance the candidate if there aren't enough numbers left
        if i + n - cur_highest > bank.len() - 1 {
            cur_highest = cur_highest + 1;
        }
    }

    // compose it into a number
    let mut jolt: u64 = 0;
    for place in 0..n {
        jolt += bats[n - place - 1] as u64 * 10u64.pow(place as u32);
    }
    jolt
}

fn part1(input: &Vec<Vec<u32>>) {
    let mut total = 0;
    for bank in input {
        let jolt = max_jolt(&bank, 2);
        total += jolt;
    }
    println!("Total: {}", total);
}

fn part2(input: &Vec<Vec<u32>>) {
    let mut total: u64 = 0;
    for bank in input {
        let jolt = max_jolt(&bank, 12);
        total += jolt;
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
