# Prompt 2
# Consider sums of a three-measurement sliding window. How many sums are larger than the previous sum?

# small enough of a file that we can read all of it in together
sum = 0
prev_sum = 1E9 # obviously bigger than any input
measurements = File.read('input').split.map(&:to_i)

(0..measurements.size-3).each do |idx|
  current_sum = measurements[idx..idx+2].reduce(&:+)
  if current_sum > prev_sum
    sum += 1
  end
  prev_sum = current_sum
end
puts sum
