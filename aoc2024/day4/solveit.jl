using LinearAlgebra

function count_ortho(grid)
    # only go forwards and down
    dims = size(grid)
    counter = 0
    for row in 1:dims[1]
        for col in 1:dims[2]
            # left to right
            if col < dims[2] - 2 && String(grid[col:col+3, row]) == "XMAS"
                counter += 1
            end
            # top to bottom
            if row < dims[1] - 2 && String(grid[col, row:row+3]) == "XMAS"
                counter += 1
            end
        end
    end
    return counter
end

function count_diag(grid)
    counter = 0
    for row in 1:size(grid, 1) - 3
        for n = 0:size(grid, 2) - 4
            # top left to bottom right diagonal
            d_str = String(diag(grid[row:row + 3, :], n))
            if d_str == "XMAS" || d_str == "SAMX"
                counter += 1
            end
            # top right to bottom left diagonal
            d_str = String(diag(grid[row:row + 3, end:-1:1], n))
            if d_str == "XMAS" || d_str == "SAMX"
                counter += 1
            end
        end
    end
    return counter
end

function part1()
    grid = stack(readlines("day4/input"))
    total = count_ortho(grid) + count_ortho(reverse(grid)) + count_diag(grid)
    println(total)
end

function part2()
    grid = stack(readlines("day4/input"))
    counter = 0
    for win in ((@view grid[row:row+2, col:col+2]) for row in 1:size(grid, 1) - 2 for col in 1:size(grid, 2) - 2)
        if win[2,2] == 'A'
            # needs 2 Ms, 2 Ss in the corners, but diagonal
            if win[1,1] != win[3,3] && win[1,3] != win[3,1]
                corners = [win[1,1] win[1,3] win[3,1] win[3,3]]
                if count(==('M'), corners) == 2 && count(==('S'), corners) == 2
                    counter += 1
                end
            end
        end
    end
    println(counter)
end


# part1()
part2()