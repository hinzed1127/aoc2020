# Test input
# answers=
# "abc

# a
# b
# c

# ab
# ac

# a
# a
# a
# a

# b"
# answers = answers.split("\n").each(&:chomp)

file = File.open('input.txt')
answers = file.readlines.map(&:chomp)

def pt_1(answers)
    current_group = []
    yes_count = 0
    answers.each_with_index do |line, idx|
        line.chars.each{ |char| current_group << char }

        if (line == "") || (idx == answers.length - 1)
            yes_count += current_group.uniq.length
            current_group = []
        end
    end

    p yes_count
end

def pt_2(answers)
    current_group = {}
    yes_count = 0
    responses = 0

    answers.each_with_index do |line, idx|
        line.chars.each do |char| 
            if current_group[char].nil?
                current_group[char] = 1
            else
                current_group[char] += 1
            end
        end

        # tally up responses, skip the blank lines
        responses += 1 unless line.length ==  0

        if (line == "") || (idx == answers.length - 1)
            current_group.values.each{ |value| yes_count += (value == responses) ? 1 : 0 }
            current_group = {}
            responses = 0
        else
        end
    end

    p yes_count
end

pt_1(answers)
pt_2(answers)
