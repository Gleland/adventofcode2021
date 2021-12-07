# Find a way to simulate lanternfish. How many lanternfish would there be after 80 days?
lanternfish = Array.new(File.read('input').split(",")).map(&:to_i)

day = 0
while day < 80
  new_fish = 0
  lanternfish.map! do |fish|
    if fish == 0
      new_fish += 1
      fish = 6
    else
      fish -= 1
    end
  end
  new_fish.times do |_|
    lanternfish << 8
  end
  day += 1
end

# 388739
pp lanternfish.size

