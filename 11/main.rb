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

# rows = test_input.split("\n").map{ |row| row.split("")}
rows = File.open("input.txt").readlines.map(&:strip).map{ |row| row.split("")}

# print rows

def adjacently_occupied(seats, row_idx, col_idx)

    occupied_neighbors = 0
    # calculate edge boundaries, then create all permutations
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

def change_seats(seats)
    new_layout = Array.new(seats.length){Array.new(seats[0].length)}

    seats.each_with_index do |row, row_idx|
        row.each_with_index do |seat, col_idx|
            if seat == "L" && adjacently_occupied(seats, row_idx, col_idx) == 0
                new_layout[row_idx][col_idx] = "#"
            elsif seat == "#" && adjacently_occupied(seats, row_idx, col_idx) >= 4
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

def pt_1(layout)
    curr_layout = layout
    next_layout = change_seats(curr_layout)

    until next_layout == curr_layout
        curr_layout = next_layout
        next_layout = change_seats(next_layout)
    end

    occupied_seats = 0
    curr_layout.each{ |row| row.each{ |seat| occupied_seats += 1 if seat == "#" } }
    p occupied_seats
end

def print_layouts(curr_layout, next_layout)
    puts "CURRENT LAYOUTS"
    curr_layout.each{|row| p row.join}
    puts
    next_layout.each{|row| p row.join}
    puts

    puts "CURRENT DIFFS"
    mismatches = []
    curr_layout.zip(next_layout) do |array| 
        mismatches << array if array.first != array.last
    end
    pp mismatches
    puts
end

pt_1(rows)
