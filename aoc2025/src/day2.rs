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

fn divide(num_str: String, high: bool) -> (u64, u64) {
    println!("Splitting {}", num_str);
    // special case for 1-digit numbers
    let num = num_str.parse::<u64>().unwrap();
    if num < 10 {
        return (10, num);
    }

    let mut mid = num_str.len() / 2;
    if num_str.len() % 2 != 0 && high {
        mid += 1;
    }

    // split in half and cast to integers
    let (first_half, _) = num_str.split_at(mid);
    (
        first_half.parse::<u64>().unwrap(), 
        num,
    )
}

fn part1(input: &Vec<(String, String)>) {
    let mut invalid: u64 = 0;
    for range in input {
        let digits = (range.0.len(), range.1.len());
        if digits.0 % 2 != 0 && digits.1 == digits.0 {
            // numbers only in an odd range, skip
            continue;
        }

        let start = divide(range.0.clone(), false);
        let end = divide(range.1.clone(), true);
        
        for left in start.0..end.0 + 1 {
            // check if the repeated number is in the range
            let rep = left * 10u64.pow(left.ilog10() + 1) + left;
            if rep >= start.1 && rep <= end.1 {
                invalid += u64::from(rep);
            }
        }
    } 
    println!("Final sum: {}", invalid);
    // 19128774587 is too low
}

fn part2(input: &Vec<(String, String)>) {}

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
