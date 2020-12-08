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
        min, max, char, pw = entry.match(/^(\d+)-(\d+) ([a-z]): ([a-z]+)$/).captures
        min = min.to_i
        max = max.to_i
        
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
        idx1, idx2, char, pw = entry.match(/^(\d+)-(\d+) ([a-z]): ([a-z]+)$/).captures
        idx1 = idx1.to_i
        idx2 = idx2.to_i
        
        match_1 = pw[idx1 - 1] == char
        match_2 = pw[idx2 - 1] == char
        if (match_1 == true && match_2 == false) || (match_1 == false && match_2 == true)
            valid_passwords += 1
        end
    end
    p valid_passwords
end

pt_1(passwords) # => 548
pt_2(passwords) # => 502
