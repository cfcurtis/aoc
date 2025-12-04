use std::fs;

fn load(filename: &str) -> Vec<Vec<char>> {
    fs::read_to_string(filename)
        .expect("Could not open file")
        .lines()
        .map(|s| s.to_string().chars().collect())
        .collect::<Vec<Vec<char>>>()
}

fn count_rolls(input: &Vec<Vec<char>>, remove: &mut Vec<Vec<bool>>) -> u32 {
    let mut total = 0;
    for (n, row) in input.iter().enumerate() {
        for (m, c) in row.iter().enumerate() {
            if *c != '@' {
                // not a roll
                continue;
            }

            let left = if m > 0 { m - 1 } else { 0 };
            let right = if m < row.len() - 1{ m + 1 } else { row.len() - 1 };
            let top = if n > 0 { n - 1 } else { 0 };
            let bottom = if n < input.len() - 1 { n + 1 } else { input.len() - 1 };

            // count the number of adjacent @s
            let mut adjacent = 0;

            for i in top..bottom + 1 {
                for j in left..right + 1 {
                    if input[i][j] == '@' {
                        adjacent += 1;
                    }
                }
            }

            // remove self
            adjacent -= 1;

            if adjacent < 4 {
                remove[n][m] = true;
                total += 1;
            }
        }
    }

    return total;
}

fn part1(input: &Vec<Vec<char>>) {
    let mut remove: Vec<Vec<bool>> = vec![vec![false; input[0].len()]; input.len()];
    let total = count_rolls(input, &mut remove);
    println!("Total: {}", total);
}

fn part2(input: &mut Vec<Vec<char>>) {
    let mut total = 0;
    let mut remove: Vec<Vec<bool>> = vec![vec![false; input[0].len()]; input.len()];
    
    let mut any_removed = true;
    
    while any_removed {
        any_removed = false;
        total += count_rolls(input, &mut remove);
        for i in 0..input.len() {
            for j in 0..input[i].len() {
                if remove[i][j] {
                    input[i][j] = '.';
                    any_removed = true;
                    remove[i][j] = false;
                }
            }
        }
    }

    println!("Total: {}", total);
}

pub fn solve(sample: bool) {
    let mut filename = "data/day4/input.txt";
    if sample {
        filename = "data/day4/sample.txt";
    }

    let mut input = load(filename);

    print!("Part 1: ");
    part1(&input);
    print!("Part 2: ");
    part2(&mut input);
}
