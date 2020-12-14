# sample_input = <<~TEST
#     F10
#     N3
#     F7
#     R90
#     F11
# TEST

# actions = sample_input.split("\n").map{ |action| action.match(/(N|S|E|W|F|R|L)(\d+)/).captures }
actions = File.open("input.txt").readlines(&:strip).map{ |action| action.match(/(N|S|E|W|F|R|L)(\d+)/).captures }
actions.each{|action| action[1] = action[1].to_i}

def pt_1(actions)
    lat = 0
    lon = 0
    face = "E"
    # modify cardinal directions for rotational shifts
    directions = %w(N E S W)

    actions.each do |action|
        direction, magnitude = action

        direction = face if direction == "F"

        if ["L", "R"].include?(direction)
            curr_idx = directions.index(face)
            
            magnitude *= -1 if direction == "L"

            shift = magnitude/90
            face = directions[(curr_idx + shift) % 4]
            next
        end

        case direction
        when "N"
            lat += magnitude
        when "S"
            lat -= magnitude
        when "E"
            lon += magnitude
        when "W"
            lon -= magnitude
        end

    end

    puts "Lat: #{lat}, Long: #{lon}"
    p lat.abs + lon.abs
end

pt_1(actions)
