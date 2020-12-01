# read input from file, create array
file = File.open('input.txt')
expense_entries = file.readlines.map{ |num| num.chomp.to_i }
# shorthand version that can't chain .chomp call
# expense_entries = file.readlines.map(&:to_i)


# Find the two entries that sum to 2020; what do you get if you multiply them together?
def pt_1(entries)
    remaining_entries = entries.dup
    values = []
    
    entries.each do |val1|
        remaining_entries.shift
        remaining_entries.each do |val2|
            if (val1 + val2) == 2020
                values = [val1, val2]
                break
            end
        break unless values.empty?
        end
    end
    
    p values[0]*values[1]
end

#In your expense report, what is the product of the three entries that sum to 2020?
def pt_2(entries)
    remaining_entries1 = entries.dup
    remaining_entries2 = entries.dup 
    remaining_entries2.shift
    values = []
    
    entries.each do |val1|
        remaining_entries1.shift
        remaining_entries1.each do |val2|
            remaining_entries2.each do |val3|
                if (val1 + val2 + val3) == 2020
                    values = [val1, val2, val3]
                    break
                end
                break unless values.empty?
            end
        end
    end
    
    p values[0]*values[1]*values[2]
end

pt_1(expense_entries)
pt_2(expense_entries)
