# Use the binary numbers in your diagnostic report to calculate the oxygen generator rating and CO2 scrubber rating, then multiply them together. What is the life support rating of the submarine? (Be sure to represent your answer in decimal, not binary.)

# most -> lest common for ordering gamma
# least -> most common for ordering gamma

# Use the binary numbers in your diagnostic report to calculate the gamma rate and epsilon rate, then multiply them together. What is the power consumption of the submarine? (Be sure to represent your answer in decimal, not binary.)

# most -> least common for ordering oxygen
# least -> most common for ordering co2

#############################
# oxygen
#############################
oxygen = ""
oxy_report = File.read('input').split("\n")
# use first row to get number of characters
# as each row is the same width
oxy_report[0].size.times do |i|
  if oxy_report.size == 1
    # one number left, that's our value
    oxygen = oxy_report[0]
    break
  end
  column = oxy_report.map{ |row| row[i]}
  num_zeroes = column.count("0")
  num_ones = column.count("1")
  if num_zeroes > num_ones
    # 0 is the most common bit
    oxygen += "0"
  else
    # either 1 is the most commit bit, or they are equal
    # in either case, we use 1 for oxygen
    oxygen += "1"
  end
  oxy_report.select!{ |row| row.start_with?(oxygen) }
end


#############################
# co2
#############################
co2 = ""
co2_report = File.read('input').split("\n")
co2_report[0].size.times do |i|
  if co2_report.size == 1
    # one number left, that's our value
    co2 = co2_report[0]
    break
  end
  column = co2_report.map{ |row| row[i]}
  num_zeroes = column.count("0")
  num_ones = column.count("1")
  if num_zeroes > num_ones
    # 1 is the least common bit
    co2 += "1"
  else
    # either 0 is the most commit bit, or they are equal
    # in either case, we use 0 for co2
    co2 += "0"
  end
  co2_report.select!{ |row| row.start_with?(co2) }
end

# now that we have our numbers in binary, convert to decimal
oxygen = oxygen.to_i(2)
co2 = co2.to_i(2)
# answ: 4856080
puts "answ: #{oxygen * co2}"
