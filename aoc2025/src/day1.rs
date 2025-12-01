use std::fs;
use std::error::Error;

fn load(filename: &str) -> Result<Vec<(char, i32)>, Box<dyn Error>> {
    let contents =  fs::read_to_string(filename)?;
    let mut result: Vec<(char, i32)> = Vec::new();
    
    for line in contents.lines() {
        let num: i32 = line[1..].parse::<i32>().unwrap();
        result.push((line.chars().nth(0).unwrap(), num));
    }
    return Ok(result);
}

fn part1() {
    let input = match load("data/day1/sample.txt") {
        Ok(data) => data,
        Err(error) => panic!("Couldn't read input: {error:?}"),
    };

    for line in input {
        println!("{}, {}", line.0, line.1);
    }
}

pub fn solve() {
    part1();
}
