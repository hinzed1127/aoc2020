test_input = <<~TEST
    L.LL.LL.LL
    LLLLLLL.LL
    L.L.L..L..
    LLLL.LL.LL
    L.LL.LL.LL
    L.LLLLL.LL
    ..L.L.....
    LLLLLLLLLL
    L.LLLLLL.L
    L.LLLLL.LL
TEST

rows = test_input.split("\n").map{ |row| row.split("")}
rows = File.open("input.txt").readlines.map(&:strip).map{ |row| row.split("")}

def adjacently_occupied(seats, row_idx, col_idx)
    occupied_neighbors = 0
    # calculate edge boundaries, then iterate through all permutations
    row_min = row_idx > 0 ? row_idx - 1 : row_idx 
    row_max = row_idx < seats.length - 1 ? row_idx + 1 : row_idx 
    col_min = col_idx > 0 ? col_idx - 1 : col_idx
    col_max = col_idx < seats[0].length - 1 ? col_idx + 1 : col_idx


    (row_min..row_max).each do |row_val|
        (col_min..col_max).each do |col_val|
            next if [row_val, col_val] == [row_idx, col_idx]
            occupied_neighbors += 1 if seats[row_val][col_val] == "#"
        end
    end

    occupied_neighbors
end

# Tallies the occupied status for the visible first seat in each of the eight directions
def visibly_occupied(seats, row_idx, col_idx)
    # puts "[#{row_idx}, #{col_idx}]"
    # puts seats[row_idx][col_idx]
    occupied_neighbors = 0    
    rows = seats.length
    columns = seats[0].length
    max_length = [rows, columns].max

    is_space_a_seat = Proc.new do |next_space|
        is_seat = false
    
        if next_space == "#"
            occupied_neighbors += 1
            is_seat = true
        elsif next_space == 'L'
            is_seat = true
        end

        is_seat
    end

    # North
    (1..max_length).each do |i|
        break if row_idx - i < 0
        break if is_space_a_seat.call(seats[row_idx - i][col_idx])
    end
    # Northeast
    (1..max_length).each do |i|
        break if (row_idx - i < 0) || (col_idx + i >= columns)
        break if is_space_a_seat.call(seats[row_idx - i][col_idx + i])
    end
    # East
    (1..max_length).each do |i|
        break if col_idx + i >= columns
        break if is_space_a_seat.call(seats[row_idx][col_idx + i])
    end
    # Southeast
    (1..max_length).each do |i|
        break if (row_idx + i >= rows) || (col_idx + 1 >= columns)
        break if is_space_a_seat.call(seats[row_idx + i][col_idx + i])
    end
    # South
    (1..max_length).each do |i|
        break if row_idx + i >= rows
        break if is_space_a_seat.call(seats[row_idx +  i][col_idx])
    end
    # Southwest
    (1..max_length).each do |i|
        break if (row_idx + i >= rows) || (col_idx - i < 0)
        break if is_space_a_seat.call(seats[row_idx + i][col_idx - i])
    end
    # West
    (1..max_length).each do |i|
        break if col_idx - i < 0
        break if is_space_a_seat.call(seats[row_idx][col_idx - i])
    end
    # Northwest
    (1..max_length).each do |i|
        break if (row_idx - i < 0) || (col_idx - i < 0)
        break if is_space_a_seat.call(seats[row_idx - i][col_idx - i])
    end  

    occupied_neighbors
end

def change_seats(seats, find_occupied, occupied_threshold = 4)
    new_layout = Array.new(seats.length){Array.new(seats[0].length)}

    seats.each_with_index do |row, row_idx|
        row.each_with_index do |seat, col_idx|
            if (seat == "L") && (find_occupied.call(seats, row_idx, col_idx) == 0)
                new_layout[row_idx][col_idx] = "#"
            elsif (seat == "#") && (find_occupied.call(seats, row_idx, col_idx) >= occupied_threshold)
                new_layout[row_idx][col_idx] = "L"
            elsif seat == '.'
                new_layout[row_idx][col_idx] = "."
            else
                new_layout[row_idx][col_idx] = seat
            end
        end
    end

    new_layout
end

def fill_seats(layout, find_occupied, occupied_threshold)
    curr_layout = layout
    next_layout = change_seats(curr_layout, find_occupied, occupied_threshold)

    until next_layout == curr_layout
        curr_layout = next_layout
        next_layout = change_seats(curr_layout, find_occupied, occupied_threshold)
    end

    occupied_seats = 0
    curr_layout.each{ |row| row.each{ |seat| occupied_seats += 1 if seat == "#" } }
    p occupied_seats
end

def print_layouts(layout)
    puts "Current Layout"
    curr_layout.each{|row| p row.join}
end

# Pt 1
fill_seats(rows, method(:adjacently_occupied), 4)

# Pt 2
fill_seats(rows, method(:visibly_occupied), 5)

# Some more tests for the visibility check in pt 2

# test_layout_1 = <<~TEST
#     .......#.
#     ...#.....
#     .#.......
#     .........
#     ..#L....#
#     ....#....
#     .........
#     #........
#     ...#.....
# TEST

# test_layout_2 = <<~TEST
#     .............
#     .L.L.#.#.#.#.
#     .............
# TEST

# test_layout_3 = <<~TEST
#     .##.##.
#     #.#.#.#
#     ##...##
#     ...L...
#     ##...##
#     #.#.#.#
#     .##.##.
# TEST

# rows1 = test_layout_1.split("\n").map{ |row| row.split("")}
# rows2 = test_layout_2.split("\n").map{ |row| row.split("")}
# rows3 = test_layout_3.split("\n").map{ |row| row.split("")}
# p visibly_occupied(rows1, 4, 3) # => 8
# p visibly_occupied(rows2, 1, 1) # => 0
# p visibly_occupied(rows2, 1, 3) # => 1
# p visibly_occupied(rows3, 3, 3) # => 0
