using DelimitedFiles

function load_input(filename::String)
    mat = readdlm(filename, Int)
    return mat[:, 1], mat[:, 2]
end

function part1()
    l1, l2 = load_input("day1/input")
    sort!(l1)
    sort!(l2)
    dist = abs.(l2 - l1)
    println(sum(dist))
end

function part2()
    l1, l2 = load_input("day1/input")
    score = 0
    for item in l1
        score += item * count(==(item), l2)
    end
    println(score)
end

# part1()
part2()