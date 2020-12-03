#test input
# coordinates =
# '..##.......
# #...#...#..
# .#....#..#.
# ..#.#...#.#
# .#...##..#.
# ..#.##.....
# .#.#.#....#
# .#........#
# #.##...#...
# #...##....#
# .#..#...#.#'
# coordinates = coordinates.split(/\n/)

file = File.open('input.txt')
coordinates = file.readlines.map(&:chomp)

def pt_1(coordinates, slopes = [3, 1])
    trees = 0
    coordinates.map.with_index do |row, idx|
        right, down = slopes

        if idx % down != 0
            next
        end

        multiplier = (idx*right)/row.length + 1
        row = row * multiplier

        # idx/down accounts for cases where down > 1
        spot = row[(idx/down)*right]

        if (spot == '#')
            trees += 1
        end
    end
    p trees
end

def pt_2(coordinates)
    trees = 1
    slopes = [[1,1], [3,1], [5,1], [7,1], [1,2]]
    slopes.each{ |slope| trees *= pt_1(coordinates, slope)}
    
    p trees
end

pt_1(coordinates)
pt_2(coordinates)

