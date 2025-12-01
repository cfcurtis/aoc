mod day1;

use std::env;

fn main() {
    let args: Vec<String> = env::args().collect();

    if args.len() < 2 {
        println!("Please provide the day to run");
        return;
    }

    let day: i32 = args[1].parse::<i32>().unwrap();

    match day { 
        1 => day1::solve(args.len() > 2),
        _ => println!("Can't solve day {}", day),
    }
}