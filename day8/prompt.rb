# In the output values, how many times do digits 1, 4, 7, or 8 appear?

input = []
output = []
data = File.readlines('input', chomp: true).each do |line|
  line = line.split(" | ")
  input << line[0]
  output << line[1]
end
pp "output: #{output}"

chars_per_digit = {
  0 => 6,
  1 => 2,
  2 => 5,
  3 => 5,
  4 => 4,
  5 => 5,
  6 => 6,
  7 => 3,
  8 => 7,
  9 => 6,
}
count = 0
[1,4,7,8].each do |digit|
  output.each do |line|
    line.split(" ").each do |group|
      if group.length == chars_per_digit[digit]
          count += 1
      end
    end
  end
end
# 375
pp count
