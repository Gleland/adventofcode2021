
# Determine the horizontal position that the crabs can align to using the least fuel possible. How much fuel must they spend to align to that position?
positions = Array.new(File.read('input').split(",")).map(&:to_i).sort

# find average
avg =  positions.reduce(&:+)/positions.size

avg_idx = positions.index(avg)
# populate with average as a starting point
min_fuel = positions.map{|p| (p- positions[avg_idx]).abs}.reduce(&:+)

# walk in both directions to see if it's a global or local minumum
# make sure we don't reach an edge
[(positions.size - avg_idx) / 2,avg_idx/2].min.times do |x|
  up = positions.index(avg) + x
  down = positions.index(avg) - x
  up_fuel = positions.map{ |p| (p - positions[up]).abs }.reduce(&:+)
  down_fuel = positions.map{ |p| (p - positions[down]).abs }.reduce(&:+)
  if up_fuel < min_fuel
    min_fuel = up_fuel
  end
  if down_fuel < min_fuel
    min_fuel = down_fuel
  end
end
# 335271
pp min_fuel

