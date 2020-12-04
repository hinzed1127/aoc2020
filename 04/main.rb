# test input
# passports =
# "ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
# byr:1937 iyr:2017 cid:147 hgt:183cm

# iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
# hcl:#cfa07d byr:1929

# hcl:#ae17e1 iyr:2013
# eyr:2024
# ecl:brn pid:760753108 byr:1931
# hgt:179cm

# hcl:#cfa07d eyr:2025 pid:166559648
# iyr:2011 ecl:brn hgt:59in"

# passports = passports.split(/\n/)

file = File.open('input.txt')
passports = file.readlines.map(&:chomp)

def pt_1(passports)
    required_fields = ['byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid']

    valid_passports = 0
    current_passport = {}

    passports.each_with_index do |line, idx|
        if line.length > 0
            fields = line.split(" ")
            fields.each do |field|
                key, val = field.split(":")
                current_passport[key] = val
            end
        end

        if line == '' || idx == passports.length - 1
            valid_passport = true
            required_fields.each do |field|
                if current_passport[field].nil?
                    valid_passport = false
                    break
                end
            end

            valid_passports += valid_passport ? 1 : 0
            current_passport = {}
            next
        end
    end

    p valid_passports
end

pt_1(passports)
# pt_1(passports[0..100])

# wrong answers: 250
# wrong answers: 238

# That's not the right answer. Curiously, it's the right answer for someone else; you might be logged in to the wrong account or just unlucky. In any case, you need to be using your puzzle input. If you're stuck, make sure you're using the full input data; there are also some general tips on the about page, or you can ask for hints on the subreddit. Please wait one minute before trying again. (You guessed 250.) [Return to Day 4]
