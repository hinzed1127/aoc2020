sample_input = <<~TEST
    F10
    N3
    F7
    R90
    F11
TEST

actions = sample_input.split("\n").map{ |action| action.match(/(N|S|E|W|F|R|L)(\d+)/).captures }
actions = File.open("input.txt").readlines(&:strip).map{ |action| action.match(/(N|S|E|W|F|R|L)(\d+)/).captures }
actions.each{|action| action[1] = action[1].to_i}

def pt_2(actions)
    ship_lat = 0
    ship_lon = 0
    waypoint_lat = 1
    waypoint_lon = 10
    waypoint_lat_diff = 1
    waypoint_lon_diff = 10
    # waypoint_quadrant = 1
    # modify cardinal directions for rotational shifts
    quadrants = [1, 2, 3, 4]

    actions.each do |action|
        direction, magnitude = action
        # puts "#{direction}, #{magnitude}"

        if ["L", "R"].include?(direction)
            # puts "ROTATE"
            # switch everthing to R to simplify transforms            
            magnitude *= -1 if direction == "L"

            shift = (magnitude/90) % 4
            # waypoint_quadrant = quadrants[(curr_idx + shift) % 4]

            case shift
            when 1
                waypoint_lat_diff, waypoint_lon_diff = -waypoint_lon_diff, waypoint_lat_diff
            when 2
                waypoint_lat_diff, waypoint_lon_diff = -waypoint_lat_diff, -waypoint_lon_diff
            when 3
                waypoint_lat_diff, waypoint_lon_diff = waypoint_lon_diff, -waypoint_lat_diff
            end

            # puts "Ship: #{ship_lon}, #{ship_lat}"
            # puts "Waypoint: #{waypoint_lon_diff},  #{waypoint_lat_diff}"
            # puts "------------------------------------------"
            next
        end

        case direction
        when "F"
            # puts "FORWARD #{waypoint_lat_face}"
            # puts "Lat face: #{waypoint_lat_face}, Lon face: #{waypoint_lon_face}"
            ship_lat += (magnitude * waypoint_lat_diff)
            ship_lon += (magnitude * waypoint_lon_diff)
            # I don't think I actually need to track the waypoint coordinates, just the diff
            waypoint_lat = ship_lat + waypoint_lat_diff
            waypoint_lon = ship_lon + waypoint_lon_diff
        when "N"
            waypoint_lat_diff += magnitude
        when "S"
            waypoint_lat_diff -= magnitude
        when "E"
            waypoint_lon_diff += magnitude
        when "W"
            waypoint_lon_diff -= magnitude
        end

        # puts "Ship:     #{ship_lon}, #{ship_lat}"
        # puts "Waypoint: #{waypoint_lon_diff},  #{waypoint_lat_diff}"
        # puts "------------------------------------------"
    end

    p ship_lat.abs + ship_lon.abs
end

pt_2(actions)
