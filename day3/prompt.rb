

# Use the binary numbers in your diagnostic report to calculate the gamma rate and epsilon rate, then multiply them together. What is the power consumption of the submarine? (Be sure to represent your answer in decimal, not binary.)

# most -> lest common for ordering gamma
# least -> most common for ordering gamma

gamma = ""
epsilon = ""
report = File.read('input').split("\n")

# use first row to get number of characters
# as each row is the same width
report[0].size.times do |i|
  column = report.map{ |row| row[i]}
  pp column.first(10)
  num_zeroes = column.count("0")
  num_ones = column.count("1")
  if num_zeroes > num_ones
    # 0 is the most common bit
    gamma += "0"
    # 1 is the least common bit
    epsilon += "1"
  else
    # 1 is the most common bit
    gamma += "1"
    # 0 is the least common bit
    epsilon += "0"
  end
end
puts gamma
puts epsilon
## now that we have our numbers in binary, convert to decimal
gamma = gamma.to_i(2)
epsilon = epsilon.to_i(2)
## power = gamma * epsilon
#answ: 3242606
puts "answ: #{gamma * epsilon}"
