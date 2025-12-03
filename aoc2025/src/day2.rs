use std::fs;

fn split_range(r: &str) -> (String, String) {
    let mut it = r.split("-");
    (
        it.next().expect("Parsing failure!").trim().to_string(),
        it.next().expect("Parsing failure!").trim().to_string(),
    )
}

fn load(filename: &str) -> Vec<(String, String)> {
    fs::read_to_string(filename)
        .expect("Could not open file")
        .split(',')
        .map(|s| split_range(s))
        .collect::<Vec<(String, String)>>()
}

fn divide(num_str: String, times: usize, high: bool) -> u64 {
    // special case for indivisible numbers
    if num_str.len() < times {
        return 1;
    }

    let mut mid = num_str.len() / times;
    if num_str.len() % times != 0 && high {
        mid += 1;
    }

    // split in parts and cast to integers
    let (first_part, _) = num_str.split_at(mid);
    let result = first_part.parse::<u64>();
    if result.is_err() {
        println!("Can't parse {} up to {} ({} divisions)", num_str, mid, times);
    }
    result.unwrap()
}

fn part1(input: &Vec<(String, String)>) {
    let mut invalid: u64 = 0;
    for range_str in input {
        let digits = (range_str.0.len(), range_str.1.len());
        if digits.0 % 2 != 0 && digits.1 == digits.0 {
            // numbers only in an odd range, skip
            println!("Skipping range from {} to {}", range_str.0, range_str.1);
            continue;
        }
        let range = (
            range_str.0.parse::<u64>().unwrap(),
            range_str.1.parse::<u64>().unwrap(),
        );

        let start = divide(range_str.0.clone(), 2, false);
        let end = divide(range_str.1.clone(), 2, true);
        
        println!("Looking for repeats between {} and {}", range.0, range.1);

        for left in start..end + 1 {
            // check if the repeated number is in the range
            let rep = left * 10u64.pow(left.ilog10() + 1) + left;
            if rep >= range.0 && rep <= range.1 {
                println!("Found {}", rep);
                invalid += u64::from(rep);
            }
        }
    } 
    println!("Final sum: {}", invalid);
}

fn part2(input: &Vec<(String, String)>) {
    let mut invalid: u64 = 0;
    for range_str in input {
        let digits = (range_str.0.len(), range_str.1.len());
        let range = (
            range_str.0.parse::<u64>().unwrap(),
            range_str.1.parse::<u64>().unwrap(),
        );
        
        println!("Looking for repeats between {} and {}", range.0, range.1);

        // keep track so we don't add duplicates
        let mut found = Vec::<u64>::new();

        for divisions in 2..digits.1 + 1 {
            let start = divide(range_str.0.clone(), divisions, false);
            let end = divide(range_str.1.clone(), divisions, true);
            for part in start..end + 1 {
                // check if the repeated number is in the range
                let mut rep = part;
                let p_digits = part.ilog10();
                for n in 1..divisions {
                    rep += part * 10u64.pow((p_digits + 1) * n as u32);
                }
                if rep >= range.0 && rep <= range.1 && !found.contains(&rep) {
                    println!("Found {}", rep);
                    invalid += u64::from(rep);
                    found.push(rep);
                }
            }
        }
    } 
    println!("Final sum: {}", invalid);
}

pub fn solve(sample: bool) {
    let mut filename = "data/day2/input.txt";
    if sample {
        filename = "data/day2/sample.txt";
    }

    let input = load(filename);

    print!("Part 1: ");
    part1(&input);
    print!("Part 2: ");
    part2(&input);
}
