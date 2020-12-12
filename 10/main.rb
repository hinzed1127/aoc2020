test_input = [16, 10, 15, 5, 1, 11, 7, 19, 6, 12, 4]
test_input_2 = [28, 33, 18, 42, 31, 14, 46, 20, 48, 47, 24, 23, 49, 45, 19, 38, 39, 11, 1, 32, 25, 35, 8, 17, 7, 9, 4, 2, 34, 10, 3]
input = File.open('input.txt').readlines.map(&:to_i)

def pt_1(ratings)
    device_joltage = 0
    one_jolt_diffs = 0
    three_jolt_diffs = 0


    while ratings.length != 0
        adapter_rating = ratings.select{|rating| (rating - device_joltage) <= 3}.min

        if (adapter_rating - device_joltage) == 1
            one_jolt_diffs += 1
        elsif (adapter_rating - device_joltage) == 3
            three_jolt_diffs += 1
        end

        device_joltage = adapter_rating
        ratings.delete(adapter_rating)
    end
    

    # your device has a built-in joltage adapter rated for 
    # 3 jolts higher than the highest-rated adapter in your bag
    three_jolt_diffs += 1
    device_joltage += 3

    # puts <<~EOS
    #     1-jolt diffs: #{one_jolt_diffs}
    #     3-jolt difs: #{three_jolt_diffs}
    #     Final voltage: #{device_joltage}
    # EOS

    p one_jolt_diffs * three_jolt_diffs
end

def pt_2(ratings)
    ratings.prepend(0)
    ratings.append(ratings.last+3)
    length_to_permutations = {1 => 1, 2 => 1, 3 => 2, 4 => 4, 5 => 7}
    permutations = []
    current_group = []

    ratings.each_with_index do |rating, idx|
        break if idx == ratings.length - 1

        current_group << rating
        if (ratings[idx+1] - rating) == 3
            permutations << length_to_permutations[current_group.length]
            current_group = []
        end
    end

    # multiply all subset permutations for total
    p permutations.inject(:*)
end

pt_1(input.clone)

# pt_2(test_input.sort)
# pt_2(test_input_2.sort)
pt_2(input.sort)
