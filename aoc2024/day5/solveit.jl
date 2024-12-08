function load_input(filename)
    stream = open(filename)
    order = []
    for line in eachline(stream)
        if isempty(line)
            break
        end
        push!(order, parse.(Int, split(line,"|")))
    end
    updates = []
    for line in eachline(stream)
        push!(updates, parse.(Int, split(line, ","))) 
    end
    return transpose(reduce(hcat, order)), updates
end

function part1()
    order, updates = load_input("day5/input")
    page_sum = 0
    for update in updates
        out_of_order = false
        for (i, num) in enumerate(update)
            if out_of_order
                break
            end

            needs_after = map(pos -> order[pos, 2], findall(==(num), order[:,1]))
            for page in needs_after
                if !isnothing(findfirst(==(page), update[1:i]))
                    out_of_order = true
                    break
                end
            end
        end
        if !out_of_order
            page_sum += update[Int(ceil(size(update, 1) / 2))]
        end
    end
    @show page_sum
end

function fix_order(order, update)
    fixed = false
    any_fix = false
    for (i, num) in enumerate(update)
        needs_after = map(pos -> order[pos, 2], findall(==(num), order[:,1]))
        for page in needs_after
            pos = findfirst(==(page), update[1:i-1])
            if !isnothing(pos)
                fixed = true
                # swap the offending page and current
                update[pos] = num
                update[i] = page
                # since we've done a swap, the rest of the needs_after array may be invalid
                break
            end
        end
    end

    while fixed
        fixed = fix_order(order, update)
        any_fix = true
    end

    return any_fix
end

function part2()
    order, updates = load_input("day5/input")
    page_sum = 0
    for update in updates
        if fix_order(order, update)
            mid = Int(ceil(size(update, 1) / 2))
            page_sum += update[mid]
            # @show size(update), mid, update
        end
    end
    @show page_sum
end

#part1()
part2()