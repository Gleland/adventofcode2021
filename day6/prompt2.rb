# How many lanternfish would there be after 256 days?
#
lanternfish = Array.new(File.read('input').split(",")).map(&:to_i)

# lanternfish have a cycle between 0 - 8 days, so we can check how many are in each
# state and simulate how many will be created based on that.
# the ith column represents the ith day in the reproductive cycle.
population_by_age = [0,0,0,0,0,0,0,0,0]

# populate histogram with initial conditions
(0..8).each do |age|
  population_by_age[age] = lanternfish.count(age)
end

# simulate the population changing every day
new_fish = population_by_age[0]
256.times do |_|
  (0..8).each do |age|
    case age
    when 0
      new_fish = population_by_age[age]
      population_by_age[age] = population_by_age[age+1]
    when 6
      # account for the number of parent fish restarting their cycle.
      # there's a 1:1 ratio of parent to new_fish, so either var can be used
      population_by_age[age] = new_fish + population_by_age[age+1]
    when 8
      population_by_age[age] = new_fish
    else
      population_by_age[age] = population_by_age[age+1]
    end
  end
end

# 1741362314973
pp population_by_age.reduce(&:+)
