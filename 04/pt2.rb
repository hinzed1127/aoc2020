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

def pt_2(passports)
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

        # second condition accounts for last entry being stripped of whitespace
        if line == '' || idx == passports.length - 1 
            valid_passport = true
            validation = /./
            required_fields.each do |field|
                case field
                    when 'byr'
                        validation = /^(19[2-9]\d)|(200[0-2])$/
                    when 'iyr'
                        validation = /^20((1\d)|(20))$/
                    when 'eyr'
                        validation = /^20((2\d)|(30))$/
                    when 'hgt'
                        validation = /^((59)|(6\d)|(7[0-6]))in|(1(([5-8]\d)|(9[0-3]))cm)$/
                    when 'hcl'
                        validation = /^#[0-9a-f]{6}$/
                    when 'ecl'
                        validation = /^(amb|blu|brn|gry|grn|hzl|oth)$/
                    when 'pid'
                        validation = /^\d{9}$/
                end

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

pt_2(passports)
