test_input = 
"35
20
15
25
47
40
62
55
65
95
102
117
150
182
127
219
299
277
309
576"

# lines = test_input.split("\n").map(&:to_i)
lines = File.open('input.txt').readlines.map(&:to_i)

def pt_1(lines, preamble = 25)
    previous_numbers = lines.first(preamble)
    lines = lines.last(lines.length - preamble)

    lines.each_with_index do |x, idx|
        contains_sum = false
        previous_numbers.each_with_index do |y, idx|
            acc = 1
            while idx + acc < previous_numbers.length
                if (y + previous_numbers[idx + acc]) === x
                    contains_sum = true
                    break
                else
                    acc += 1
                    next
                end
            end
        end

        if contains_sum
            previous_numbers.shift
            previous_numbers << x
            next
        else
            p x
            return x
            break
        end
    end
end

def pt_2(lines, invalid_num)
    lines.each_with_index do |x, idx|
        found_sum = false
        acc = 1

        while (idx + acc < lines.length) && (lines[idx..(idx+acc)].sum <= invalid_num)
            if (lines[idx..(idx+acc)].sum === invalid_num)
                found_sum = true
                p lines[idx..(idx+acc)].minmax.sum
                break
            else
                acc += 1
                next
            end
        end

        break unless !found_sum
    end
end

invalid_num = pt_1(lines, 25)
pt_2(lines, invalid_num)
