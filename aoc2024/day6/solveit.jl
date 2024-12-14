function part1()
    grid = stack(readlines("day6/sample"); dims=1)
    pos = findfirst(==('^'), grid)
    dir = [-1 0]
    while checkbounds(Bool, grid, pos)
        grid[pos] = 'X'
        front = pos + CartesianIndex(Tuple(dir))
        if checkbounds(Bool, grid, front) && grid[front] == '#'
            dir *= [0 -1; 1 0]
        else
            pos = front
        end
    end
    p1 = count(==('X'), grid)
    @show p1
end

function loops(grid, start_pos)
    pos = start_pos
    dir = [-1 0]
    steps = 0
    while checkbounds(Bool, grid, pos)
        front = pos + CartesianIndex(Tuple(dir))
        if !checkbounds(Bool, grid, front)
            # walked off the edge, not a viable loop
            return false
        elseif steps > length(grid)
            # surely we've looped by now!
            return true
        end
        
        if grid[front] == '#'
            dir *= [0 -1; 1 0]
        else
            # take a step
            pos = front
            steps += 1
        end
    end
    # Not sure how this might happen, but just in case...
    println("Got to a weird spot!")
    return false
end

function part2()
    grid = stack(readlines("day6/input"); dims=1)
    start_pos = findfirst(==('^'), grid)
    potential_obstacles = findall(==('.'), grid)
    p2 = 0
    for o_pos in potential_obstacles
        # place an obstacle and see what happens
        temp_grid = deepcopy(grid)
        temp_grid[o_pos] = '#'
        if loops(temp_grid, start_pos)
            p2 += 1
        end
    end
    @show p2
end
part1()
part2()