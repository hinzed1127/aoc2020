file = File.open('input.txt')
seats = file.readlines.map(&:chomp)

def calc_seat_id(seat)
    row = calc_binary_partition(seat.chars.first(7), 0, 127, ['F', 'B'])
    col = calc_binary_partition(seat.chars.last(3), 0, 7, ['L', 'R'])
    (row * 8) + col
end

def calc_binary_partition(chars, min = 0, max = 127, bounds = ['F', 'B'])
    chars.each do |char|
        # puts "#{min} - #{max}"
        split_diff = (max - min) / 2
        if char == bounds[0]
            max = min + split_diff
        elsif char == bounds[1]
            min = max - split_diff
        end
    end
    
    # min == max at this point, return either
    min
end

def pt_1(seats)
    max_seat_id = 0
    seats.map{ |seat| max_seat_id = [max_seat_id, calc_seat_id(seat)].max }

    p max_seat_id
end

def pt_2(seats)
    seat_ids = seats.map{ |seat| calc_seat_id(seat) }.sort

    seat_ids.each_with_index do |seat, idx|
        if (idx == 0) || (idx == seat_ids.length - 1)
            next
        end

        if seat_ids[idx - 1] != seat - 1
            p seat - 1
            break
        elsif seat_ids[idx + 1] != seat + 1
            p seat + 1
            break
        end
    end
end
        

# Test values
# calc_seat_id('BFFFBBFRRR') # => 567
# calc_seat_id('FFFBBBFRRR') # => 119
# calc_seat_id('BBFFBBFRLL') # => 820

pt_1(seats)
pt_2(seats)
