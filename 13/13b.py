with open("test_input.txt") as F:
    F.readline() # ignore the first line of the input
    buses = F.readline().strip().split(',')

# create pairs of (divisor, remainder) for every available bus
buses = [(int(buses[i]), (int(buses[i]) - i) % int(buses[i]))
    for i in range(len(buses)) if buses[i] != 'x']

print(buses)

result = 0
increment = 1

for bus in buses:
    print(result, result % bus[0], bus[1])
    while result % bus[0] != bus[1]:
        result += increment
    increment *= bus[0]

print(result)
