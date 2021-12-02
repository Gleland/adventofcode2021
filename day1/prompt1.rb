# Prompt
# How many measurements are larger than the previous measurement?

# small enough of a file that we can read all of it in together
sum = 0
measurements = File.read('input').split.map(&:to_i)
measurements.each_index do |idx|
  next if idx == 0 # skip beginning
  if measurements[idx] - measurements[idx-1] > 0
    sum += 1
  end
end

puts sum


