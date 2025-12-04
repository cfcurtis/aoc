mod day1;
mod day2;
mod day3;
mod day4;

use std::env;

fn main() {
    let args: Vec<String> = env::args().collect();

    if args.len() < 2 {
        println!("Please provide the day to run");
        return;
    }

    let mut sample = false;
    if args.len() > 2 && args[2] == "sample" {
        sample = true;
    }

    let day: i32 = args[1].parse::<i32>().unwrap();

    match day { 
        1 => day1::solve(sample),
        2 => day2::solve(sample),
        3 => day3::solve(sample),
        4 => day4::solve(sample),
        _ => println!("Can't solve day {}", day),
    }
}