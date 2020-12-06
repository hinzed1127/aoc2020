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

def count_valid_passports(passports, validate = false)
    required_fields = ['byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid']
    validations_regex = {
        #byr (Birth Year) - four digits; at least 1920 and at most 2002.
        'byr' => /^(19[2-9]\d)|(200[0-2])$/,
        #iyr (Issue Year) - four digits; at least 2010 and at most 2020.
        'iyr' => /^20((1\d)|(20))$/,
        #eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
        'eyr' => /^20((2\d)|(30))$/,
        #hgt (Height) - a number followed by either cm or in:
        #   If cm, the number must be at least 150 and at most 193.
        #   If in, the number must be at least 59 and at most 76.
        'hgt' => /^((59)|(6\d)|(7[0-6]))in|(1(([5-8]\d)|(9[0-3]))cm)$/,
        #hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
        'hcl' => /^#[0-9a-f]{6}$/,
        #ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
        'ecl' => /^(amb|blu|brn|gry|grn|hzl|oth)$/,
        #pid (Passport ID) - a nine-digit number, including leading zeroes.
        'pid' => /^\d{9}$/,
        #cid (Country ID) - ignored, missing or not.
        'cid' => /./,
    }

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

        # second condition accounts for last entry being stripped of whitespace by Ruby
        if line == '' || idx == passports.length - 1 
            valid_passport = true
            validation = /./ # automatically match all when validation is false
            required_fields.each do |field|
                validation = validations_regex[field] unless !validate

                if current_passport[field].nil? || !current_passport[field].match(validation)
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

# Part 1, no validations on values
count_valid_passports(passports)
# Part 2, include validations
count_valid_passports(passports, true)
