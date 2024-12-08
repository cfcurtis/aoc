function part1()
    grid = stack(readlines("day6/input"); dims=1)
    pos = findfirst(==('^'), grid)
    dir = [-1 0]
    while checkbounds(Bool, grid, pos)
        front = pos + CartesianIndex(Tuple(dir))
        if checkbounds(Bool, grid, front) && grid[front] == '#'
            dir *= [0 -1; 1 0]
        else
            pos = front
            if checkbounds(Bool, grid, front)
                grid[pos] = 'X'
            end
        end
    end
    @show count(==('X'), grid)
end

part1()