
# Determine the horizontal position that the crabs can align to using the least fuel possible so they can make you an escape route! How much fuel must they spend to align to that position?
positions = Array.new(File.read('input').split(",")).map(&:to_i).sort

def additive_factorial(num)
  # return n + n-1 + n-2 + ... + 1
  sum = 0
  while num >= 1 do
    sum += num
    num -=1
  end
  return sum
end

# find average
avg =  positions.reduce(&:+)/positions.size
avg_idx = positions.index(avg)

# calculate with average as a starting point
min_fuel = positions.map{|p| additive_factorial((p- positions[avg_idx]).abs)}.reduce(&:+)
#
# walk a decent distance in both directions to see if it's a global or local minumum
# make sure we don't reach an edge
num_guesses = [(positions.size - avg_idx) / 2, avg_idx/2].min
num_guesses.times do |x|
  up = positions.index(avg) + x
  down = positions.index(avg) - x
  up_fuel = positions.map{ |p| additive_factorial((p + positions[up]).abs)}.reduce(&:+)
  down_fuel = positions.map{ |p| additive_factorial((p - positions[down]).abs) }.reduce(&:+)
  if up_fuel < min_fuel
    min_fuel = up_fuel
  end
  if down_fuel < min_fuel
    min_fuel = down_fuel
  end
end
# 95851339
pp min_fuel
