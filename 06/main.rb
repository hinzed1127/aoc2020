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
p answers

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

pt_1(answers)
