# Find the first illegal character in each corrupted line of the navigation subsystem. What is the total syntax error score for those errors?

lines = File.readlines('input', chomp: true)
char_to_points = {
    ")" =>  3,
    "]" =>  57,
    "}" =>  1197,
    ">" =>  25137,
}
open_chars = {
  "[" => "]",
  "{" => "}" ,
  "(" => ")",
  "<" => ">",
}

char_stack = []
broken_chars = []
lines.each_with_index do |line, idx|
  char_stack = []
  line.chars do |char|
    if char_stack.empty?
        # starting character to be added
        char_stack << char
    elsif open_chars.keys.include? char
      # this is an opening character, add to stack
      char_stack << char
    else
        # must be a closing char, check if it matches the latest in the stack
        if char == open_chars[char_stack[-1]]
          # matches! we can pop the last character to remove it
          char_stack.pop
        elsif char != open_chars[char_stack[-1]]
          # doesn't match! this is a broken line.
          # keep the broken character and mark for deletion
          broken_chars << char
          break
        end
    end
  end
end

# 290691
pp broken_chars.flatten.map{|c| char_to_points[c]}.reduce(&:+)
