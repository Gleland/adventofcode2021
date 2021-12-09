require 'set'
# For each entry, determine all of the wire/segment connections and decode the four-digit output values. What do you get if you add up all of the output values?

=begin

Let's define elements in an array, to characterize and standardize on how we'll
reference a 7-digit display.
The following diagram represents the display, with each number showing which position the given segment will be located in the standardized array:

         0th
     -----------
     |         |
 1st |         | 2nd
     |         |
     |         |
     |   3rd   |
     -----------
     |         |
     |         |
 4th |         | 5th
     |         |
     |   6th   |
     -----------

so..
    0 will be represented as Set(a[0], a[1], a[2], a[4], a[5], a[6])
    1 will be represented as Set(a[2], a[5])
    2 will be represented as Set(a[0], a[2], a[3], a[4], a[6])
    3 will be represented as Set(a[0], a[2], a[3], a[5], a[6])
    4 will be represented as Set(a[1], a[2], a[3], a[5])
    5 will be represented as Set(a[0], a[1], a[3], a[5], a[6])
    6 will be represented as Set(a[0], a[1], a[3], a[4], a[5], a[6])
    7 will be represented as Set(a[0], a[2], a[7])
    8 will be represented as Set(a[0], a[1], a[2], a[3], a[4], a[5], a[6])
    9 will be represented as Set(a[0], a[1], a[2], a[3], a[5], a[6])

With this, we can:
 - create an array of every permutation,
 - check each given line of input against all permutations to see which matches,
 - use the match as a reference to extract and sum the numbers in the output
=end


permutations =  ["a", "b", "c", "d", "e", "f", "g"].permutation.to_a
input, output = [], []

File.readlines('input', chomp: true).each do |line|
  line = line.split(" | ")
  input << line[0]
  output << line[1]
end

def number_arrangements(a)
  return [
    [a[0], a[1], a[2], a[4], a[5], a[6]].to_set,       # 0
    [a[2], a[5]].to_set,                               # 1
    [a[0], a[2], a[3], a[4], a[6]].to_set,             # 2
    [a[0], a[2], a[3], a[5], a[6]].to_set,             # 3
    [a[1], a[2], a[3], a[5]].to_set,                   # 4
    [a[0], a[1], a[3], a[5], a[6]].to_set,             # 5
    [a[0], a[1], a[3], a[4], a[5], a[6]].to_set,       # 6
    [a[0], a[2], a[5]].to_set,                         # 7
    [a[0], a[1], a[2], a[3], a[4], a[5], a[6]].to_set, # 8
    [a[0], a[1], a[2], a[3], a[5], a[6]].to_set,       # 9
  ]
end

total_sum = 0
input.each_with_index do |line, idx|
  permutations.each do |perm|
    expected_arrangements = number_arrangements(perm)
    sets = line.split.map{ |group| group.chars.to_set }.to_set
    if sets.all? {|set| expected_arrangements.include? set}
      # this is the matching permutation! find the output with this match.
     partial_sum = ""
     output[idx].split.each do |out_group|
       # the index = the number to use, due to how the array is designed
       partial_sum += expected_arrangements.index(out_group.chars.to_set).to_s
     end
     total_sum += partial_sum.to_i
   end
  end
end

# 1019355
pp total_sum
