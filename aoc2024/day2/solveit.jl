using DelimitedFiles

function load_input(filename::String)
    records = []
    for line in readlines(filename)
        push!(records, parse.(Int, split(line)))
    end
    return records
end

function is_safe(record)
    dl = diff(record)
    first_dir = sign(dl[1])
    for d in dl
        if sign(d) != first_dir || d > 3 || d < -3 || d == 0
            return false
        end
    end
    return true
end 

function part1()
    reports = load_input("day2/input")
    n_safe = 0
    for record in reports
        n_safe += is_safe(record)
    end
    println(n_safe)
end

function part2()
    reports = load_input("day2/input")
    n_safe = 0
    for record in reports
        if is_safe(record)
            n_safe += 1
        else
            # check by brute force
            for i in eachindex(record)
                if (is_safe(deleteat!(copy(record), i)))
                    n_safe += 1
                    break
                end
            end
        end 
    end
    println(n_safe)
end

# part1()
part2()