use std::fs;

fn load(filename: &str) -> (Vec<(u64, u64)>, Vec<u64>) {
    let mut ranges: Vec<(u64, u64)> = Vec::new();
    let mut ingredients: Vec<u64> = Vec::new();
    let contents = fs::read_to_string(filename).expect("Could not open file");
    let mut lines = contents.lines();

    loop {
        let line = lines.next().expect("Couldn't read line!");
        if line.is_empty() {
            break;
        }

        let range = line
            .split("-")
            .map(|s| s.to_string().parse::<u64>().unwrap())
            .collect::<Vec<u64>>();
        ranges.push((range[0], range[1]));
    }

    for line in lines {
        ingredients.push(line.parse::<u64>().unwrap());
    }

    (ranges, ingredients)
}

fn part1(ranges: &Vec<(u64, u64)>, ingredients: &Vec<u64>) {
    let mut fresh = 0;

    for ingredient in ingredients {
        for range in ranges {
            if *ingredient >= range.0 && *ingredient <= range.1 {
                fresh += 1;
                break;
            }
        }
    }

    println!("Total fresh: {}", fresh);
}

fn part2(ranges: &Vec<(u64, u64)>) {
    let mut total: u64 = 0;
    
    for i in 0..ranges.len() {
        let mut start = ranges[i].0;
        let mut end = ranges[i].1;

        // loop through the previous ranges and check if this one is accounted for already
        for j in 0..i {
            if start >= ranges[j].0 && start <= ranges[j].1 {
                start = ranges[j].1 + 1;
            }
            if end >= ranges[j].0 && end <= ranges[j].1 {
                end = ranges[j].0 - 1;
            }
        }

        if end > start {
            total += end - start + 1;
        }
    }
    println!("Total fresh: {}", total);
}

pub fn solve(sample: bool) {
    let mut filename = "data/day5/input.txt";
    if sample {
        filename = "data/day5/sample.txt";
    }

    let (ranges, ingredients) = load(filename);

    print!("Part 1: ");
    part1(&ranges, &ingredients);
    print!("Part 2: ");
    part2(&ranges);
}
