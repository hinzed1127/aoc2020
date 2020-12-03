# Test Input
# passwords = [
#     '1-3 a: abcde',
#     '1-3 b: cdefg',
#     '2-9 c: ccccccccc',
# ]

file = File.open('input.txt')
passwords = file.readlines.map(&:chomp)


def pt_1(passwords)
    valid_passwords = 0

    passwords.each do |entry|
        validation, pw = entry.split(':')
        pw.strip!
        limit, char = validation.split(' ')
        # min, max = limit.split('-').map{ |x| x.to_i }
        min, max = limit.split('-').map(&:to_i)
        
        char_count = pw.count(char)
        if char_count >= min && char_count <= max
            valid_passwords += 1
        end
    end
    p valid_passwords
end

def pt_2(passwords)
    valid_passwords = 0

    passwords.each do |entry|
        validation, pw = entry.split(':')
        pw.strip!
        indices, char = validation.split(' ')
        idx1, idx2 = indices.split('-').map(&:to_i)
        
        match_1 = pw[idx1 - 1] == char
        match_2 = pw[idx2 - 1] == char
        if (match_1 == true && match_2 == false) || (match_1 == false && match_2 == true)
            valid_passwords += 1
        end
    end
    p valid_passwords
end

pt_1(passwords)
pt_2(passwords)
