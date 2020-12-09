test_input =
"nop +0
acc +1
jmp +4
acc +3
jmp -3
acc -99
acc +1
jmp -4
acc +6
"

lines = test_input.split("\n").map(&:strip)
lines = File.open('input.txt').readlines.map(&:strip)
instructions = []
lines.each do |line|
    op, arg = line.match(/^(acc|jmp|nop) ((\+|-)\d+)$/).captures
    instructions << [op, arg.to_i]
end

def pt_1(instructions)
    acc = 0
    visited_indices = []
    curr_idx = 0

    until visited_indices[curr_idx]
        visited_indices[curr_idx] = true
        op, arg = instructions[curr_idx]

        case op
        when "nop"
            nil
        when "acc"
            acc += arg
        when "jmp"
            curr_idx += arg
            next
        end

        curr_idx += 1
    end

    p acc
end

def program(instructions)
    acc = 0
    visited_indices = []
    curr_idx = 0

    until curr_idx == instructions.length
        if visited_indices[curr_idx]
            return "CORRUPTED"
        else
            visited_indices[curr_idx] = true
        end
        op, arg = instructions[curr_idx]

        case op
        when "nop"
            nil
        when "acc"
            acc += arg
        when "jmp"
            curr_idx += arg
            next
        end

        curr_idx += 1
    end

    acc
end

# Fix the program so that it terminates normally by changing exactly one jmp (to nop) or nop (to jmp).
# What is the value of the accumulator after the program terminates?
def pt_2(instructions)
    instructions.each_with_index do |instruction, idx|
        op = instruction[0]

        case op
        when "nop"
            instruction[0] = "jmp"
            old_val = "nop"
            
        when "jmp"
            instruction[0] = "nop"
            old_val = "jmp"
        else
            # skip noops
            next
        end

        result = program(instructions)
        if result == "CORRUPTED"
            instruction[0] = old_val
            next
        else
            # return the FIRST correct result
            p result
            return
        end
    end
end

pt_1(instructions) # => 2080
pt_2(instructions) # => 2477

# wrong answers for pt 2 - return the FIRST one
# 1219 - too low
# 1381 - too low
# 1631 - too low
# 2570

