const dir_char = Dict([-1 0]=>'^',[1 0]=>'v', [0 -1]=>'<', [0 1]=>'>')
const char_dir = Dict(value=>key for (key, value) in dir_char)

function part1()
    grid = stack(readlines("day6/sample"); dims=1)
    pos = findfirst(==('^'), grid)
    first_pos = pos
    dir = [-1 0]
    while checkbounds(Bool, grid, pos)
        grid[pos] = dir_char[dir]
        front = pos + CartesianIndex(Tuple(dir))
        if checkbounds(Bool, grid, front) && grid[front] == '#'
            dir *= [0 -1; 1 0]
        else
            pos = front
        end
    end
    p1 = count(x->(x != '#' && x != '.'), grid)
    @show p1
    for (i, row) in enumerate(eachrow(grid))
        println(i, String(row))
    end
    return grid, first_pos
end

function loops(grid, start_pos, dir)
    pos = start_pos
    second = nothing
    while checkbounds(Bool, grid, pos)
        front = pos + CartesianIndex(Tuple(dir))
        if !checkbounds(Bool, grid, front)
            # walked off the edge, not a viable loop
            return false
        end
        
        if grid[front] == '#'
            dir *= [0 -1; 1 0]
        else
            # update the second location if it's the first time around
            if isnothing(second)
                second = front
            end
            # if we're back at the start and heading back the same way, it's a loop
            if pos == start_pos && front == second
                return true
            end
            # take a step
            pos = front
        end
    end
    # Not sure how this might happen, but just in case...
    println("Got to a weird spot!")
    return false
end

function part2()
    grid, first_pos = part1()
    p2 = 0
    visited = findall(x->(x != '#' && x != '.'), grid)

    # yay brute force - try an obstacle in every grid location (that wasn't already there)
    for loc in CartesianIndices(grid)
        if loc == first_pos || grid[loc] == '#'
            continue
        end

        # make an independent copy and place the obstacle
        grid_copy = deepcopy(grid)
        grid_copy[loc] = '#'
        for start in filter(!=(loc), visited)
            if loops(grid_copy, start, char_dir[grid[start]])
                p2 += 1
                # break the loop to not double-count the obstacle
                break
            end
        end
    end
    @show p2
end

function test_loop()
    (grid, first_pos) = part1()
    grid[7,4] = '#' # printing press example
    if loops(grid, first_pos, [-1 0])
        println("Printing press loop encountered")
    end
end

# part1()
part2()

# test_loop()