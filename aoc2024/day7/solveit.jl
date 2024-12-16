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

function concat(lhs, rhs)
    return lhs * 10^(ndigits(rhs)) + rhs
end

function uncat(num, rhs)
    divisor = 10^ndigits(rhs)
    if (num - rhs) % divisor != 0
        return -1
    else
        return (num - rhs) ÷ divisor
    end
end

function can_do(tv, nums, p)
    # start at the end and recursively check if a +/* should be done
    # base case: we've gone through all the numbers and it works out
    if (length(nums) == 1)
        return (tv == nums[1])
    end

    success = false
    # if we can divide, do it
    if (tv % nums[end] == 0)
        success = can_do(tv ÷ nums[end], nums[1:end-1], p)
    end

    # if that didn't work, try subtracting
    success = success || can_do(tv - nums[end], nums[1:end-1], p)

    # if it's part 2 and still no success, try uncatting
    if !success && p == 2
        lhs = uncat(tv, nums[end])
        if lhs > 0
            success = can_do(lhs, nums[1:end-1], p)
        end
    end
    return success
end

function part(p)
    test_vals, operands = load_input("day7/input")
    result = 0
    for (tv, nums) in zip(test_vals, operands)
        result += tv * can_do(tv, nums, p)
    end
    return result
end

@show part(1)
@show part(2)