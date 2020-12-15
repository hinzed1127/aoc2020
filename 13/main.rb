test_input = <<~TEST
    939
    7,13,x,x,59,x,31,19
TEST

test_input = test_input.split("\n").map(&:strip)
notes = File.open('input.txt').readlines.map(&:strip)

def pt_1(notes)
    timestamp = notes[0].to_i
    buses = notes[1].split(",").map(&:to_i).select(&:nonzero?)

    wait_times = {}
    buses.each do |bus|
        if bus == "x"
            next
        elsif (timestamp % bus.to_i) == 0
            # on the off chance that there's a zero minute wait time
            return 0
        else
            # wait time = bus_number - remainder of timestamp / bus_number
            wait_times[bus] = bus - (timestamp % bus)
        end
    end

    # find the longest wait time, return bus * wait_time
    shortest_wait = wait_times.min_by{ |bus, wait_time| wait_time}
    puts "#{shortest_wait}, #{shortest_wait.inject(:*)}"
end

def pt_2(buses)
    buses = buses.split(",").map{ |bus| bus.to_i.nonzero? ? bus.to_i : bus}

    acc = buses[0]
    time = acc
    found_time = false

    loop do
        # p time
        buses.each_with_index do |bus_num, idx|
            next if bus_num == "x"

            break if (time + idx) % bus_num != 0 

            found_time = true if (idx == buses.length - 1)
        end

        break if found_time
        time += acc
    end

    puts time
end

pt_1(notes)

# Test inputs for part 2
pt_2(test_input[1]) # => 1068781
pt_2("17,x,13,19") # => 3417.
pt_2("67,7,59,61") # => 754018.
pt_2("67,x,7,59,61") # => 779210.
pt_2("67,7,x,59,61") # => 1261476.
pt_2("1789,37,47,1889") # => 1202161486.

# pt_2(notes[1])
