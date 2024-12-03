function sumprod(input::String)
    re = r"mul\((\d+),(\d+)\)"
    args = reduce(vcat, [parse.(Int, m.captures) for m in eachmatch(re, input)]')
    return sum(args[:,1].*args[:,2])
end

function part1()
    filename = "day3/input"
    println(sumprod(read(filename, String)))
end

function remove_dont(input::String)
    # replace with do() to keep track of what's being removed
    result = replace(input, r"(?:don't\(\)[\S\s]*?)+do\(\)" => "do()")
    result = replace(result, r"don't\(\)[\S\s]*?$" => "")
    # write("day3/stripped", result)
    return result
end

function part2()
    filename = "day3/input"
    println(sumprod(remove_dont(read(filename, String))))
end

# part1()
part2()