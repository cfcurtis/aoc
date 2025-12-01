use std::error::Error;
use std::fs;

fn load(filename: &str) -> Result<Vec<(char, i32)>, Box<dyn Error>> {
    let contents = fs::read_to_string(filename)?;
    let mut result: Vec<(char, i32)> = Vec::new();

    for line in contents.lines() {
        let num: i32 = line[1..].parse::<i32>().unwrap();
        result.push((line.chars().nth(0).unwrap(), num));
    }
    return Ok(result);
}

// modulo function that ensures positive numbers
fn modulo(n: i32, m: i32) -> i32 {
    ((n % m) + m) % m
}

fn part1(input: &Vec<(char, i32)>) {
    let mut zeros = 0;
    let mut pos = 50;
    for turn in input {
        pos += if turn.0 == 'L' { -turn.1 } else { turn.1 };
        pos = modulo(pos, 100);

        if pos == 0 {
            zeros += 1;
        }
    }

    println!("{}", zeros);
}

fn part2(input: &Vec<(char, i32)>) {
    let mut zeros = 0;
    let mut pos = 50;
    for turn in input {
        pos += if turn.0 == 'L' { -turn.1 } else { turn.1 };

        let mod_pos = modulo(pos, 100);
        if turn.1 < 100 && pos != mod_pos {
            // case 1: turn < 100, but we passed 0
            pos = mod_pos;
            zeros += 1;
        } else if turn.1 > 100 {
            // case 2: multiple wraps
            pos = mod_pos;
            zeros += turn.1 / 100;
        } else if pos == 0 {
            // case 3: exactly at 0
            zeros += 1;
        }
    }

    println!("{}", zeros);
}

pub fn solve(sample: bool) {
    let mut filename = "data/day1/input.txt";
    if sample {
        filename = "data/day1/sample.txt";
    }

    let input = match load(filename) {
        Ok(data) => data,
        Err(error) => panic!("Couldn't read input: {error:?}"),
    };

    print!("Part 1: ");
    part1(&input);
    print!("Part 2: ");
    part2(&input);
}
