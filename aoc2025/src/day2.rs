use std::fs;
// use math::round;

fn split_range(r: &str) -> (String, String) {
    let mut it = r.split("-");
    (
        it.next().expect("Parsing failure!").to_string(),
        it.next().expect("Parsing failure!").to_string(),
    )
}

fn load(filename: &str) -> Vec<(String, String)> {
    fs::read_to_string(filename)
        .expect("Could not open file")
        .split(',')
        .map(|s| split_range(s))
        .collect::<Vec<(String, String)>>()
}

fn divide(mut num_str: String, digits: usize) -> (u32, u32) {
    let mut mid = num_str.len() / 2;

    // split in half and cast to integers
    let second_half = num_str.split_off(mid);
    (
        num_str.parse::<u32>().unwrap(), 
        second_half.parse::<u32>().unwrap(),
    )
}

fn part1(input: &Vec<(String, String)>) {
    let mut invalid: u32 = 0;
    for range in input {
        let digits = (range.0.len(), range.1.len());
        if digits.0 % 2 != 0 && digits.1 == digits.0 {
            // numbers only in an odd range, skip
            continue;
        }

        if digits.0 % 2 != 0 && digits.1 % 2 == 0 {
            
        }


        let max_digits = range.1.len();

        let start = divide(range.0.clone(), max_digits);
        let end = divide(range.1.clone(), max_digits);
        
        println!("Left loop from {} to {}", start.0, end.0);

        for left in start.0..end.0 {
            // check if 
        }
    } 
    println!("Final sum: {}", invalid);
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
