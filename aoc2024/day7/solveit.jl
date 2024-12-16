function load_input(filename)
    test_vals = BigInt[]
    operands = Vector{BigInt}[]
    for line in readlines(filename)
        nums = parse.(BigInt, split(replace(line, ":" => "")))
        push!(test_vals, nums[1])
        push!(operands, nums[2:end])
    end

    return test_vals, operands
end

function can_do(tv, nums)
    # start at the end and recursively check if a +/* should be done
    # base case: we've gone through all the numbers and it works out
    if (length(nums) == 1)
        return (tv == nums[1])
    end

    div_can_do = false
    # if we can divide, do it, otherwise subtract
    if (tv % nums[end] == 0)
        div_can_do = can_do(tv ÷ nums[end], nums[1:end-1])
    else
        return can_do(tv - nums[end], nums[1:end-1])
    end

    # if it divided evenly the first time, but ultimately led to failure,
    # try again with subtraction
    if div_can_do
        return true
    else
        return can_do(tv - nums[end], nums[1:end-1])
    end
end

function part1()
    test_vals, operands = load_input("day7/input")
    p1 = 0
    for (tv, nums) in zip(test_vals, operands)
        p1 += tv * can_do(tv, nums)
    end
    @show p1
end

part1()