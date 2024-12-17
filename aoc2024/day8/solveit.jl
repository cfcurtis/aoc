function part1()
    grid = stack(readlines("day8/input"); dims=1)
    antinodes = zeros(Bool, size(grid))
    for antenna in filter(!=('.'), unique(grid))
        @show antenna
        indices = findall(==(antenna), grid)
        for pair in Iterators.product(indices, indices)
            if pair[2] == pair[1]
                continue
            end
            dpair = pair[2] - pair[1]
            anode = pair[1] - dpair
            if checkbounds(Bool, grid, anode)
                antinodes[anode] = true
            end
            anode = pair[2] + dpair
            if checkbounds(Bool, grid, anode)
                antinodes[anode] = true
            end
        end
    end
    @show sum(antinodes)
end

part1()