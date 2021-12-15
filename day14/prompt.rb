# Apply 10 steps of pair insertion to the polymer template and find the most and least common elements in the result. What do you get if you take the quantity of the most common element and subtract the quantity of the least common element?

input = File.read('input').split("\n")
polymer_template = input[0]

rules = {}
input.select{ |line| line.include? "->" }.each do |rule|
  key,val = rule.split(" -> ")
  rules[key] = val
end

polymers_tally = polymer_template.chars.each_cons(2).tally


40.times do
  new_polymers_tally = Hash.new(0)
  polymers_tally.each do |polymer, occurences|
    new_element = rules[polymer.join]
    new_polymer_1 = [polymer[0],new_element]
    new_polymer_2 = [new_element,polymer[1]]
    new_polymers_tally[new_polymer_1] += occurences
    new_polymers_tally[new_polymer_2] += occurences
  end
  polymers_tally = new_polymers_tally
end

B = polymers_tally.select{ |polymer, _| polymer[0] == 'B'}.map{ |key,val| val}.reduce(&:+)
C = polymers_tally.select{ |polymer, _| polymer[0] == 'C'}.map{ |key,val| val}.reduce(&:+)
H = polymers_tally.select{ |polymer, _| polymer[0] == 'H'}.map{ |key,val| val}.reduce(&:+)
N = polymers_tally.select{ |polymer, _| polymer[0] == 'N'}.map{ |key,val| val}.reduce(&:+)

# part 1 (10 steps): 3143
# part 2 (40 steps): 4110215602456
pp "answ: #{[B,C,H,N].max - ([B,C,H,N].min+1)}"
