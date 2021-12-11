# Find the completion string for each incomplete line, score the completion strings, and sort the scores. What is the middle score?

lines = File.readlines('input', chomp: true)
open_chars = {
  "[" => "]",
  "{" => "}" ,
  "(" => ")",
  "<" => ">",
}

char_stack = []
incomplete_lines = []
lines.each_with_index do |line, idx|
  char_stack = []
  line_keep = true
  line.chars do |char|
    if char_stack.empty?
        char_stack << char
    elsif open_chars.keys.include? char
      char_stack << char
    else
        # must be a closing char, check if it matches the latest in the stack
        if char == open_chars[char_stack[-1]]
          char_stack.pop
        elsif char != open_chars[char_stack[-1]]
          # this is a broken line, delete it
          line_keep = false
          break
        end
    end
  end
  if line_keep
  incomplete_lines << line
  end
end

autocomplete_scoring = {
    ")" => 1,
    "]" => 2,
    "}" => 3,
    ">" => 4,
}

# now we only have incomplete lines, let's iterate and find the closing chars
char_stack = []
closing_chars = []
puts "incomplete_lines: #{incomplete_lines}"
completing_chars = incomplete_lines.map do |line|
  char_stack = []
  line_keep = true
  line.chars do |char|
    if char_stack.empty?
        # starting character
        char_stack << char
    elsif open_chars.keys.include? char
      # open character, let's add to the stack to track
      char_stack << char
    else
      # must be a closing char, remove its companion from the stack
      char_stack.pop
    end
  end
  # generate remaining chars that will close the lonely chars
  char_stack.map{ |c| open_chars[c]}.reverse
end

# now that we have all the closing chars, let's score them
points = completing_chars.map{ |row| row.map{ |c| autocomplete_scoring[c]} }
total_points = points.map do |row|
  total_score = 0
  row.each do |num|
    total_score *= 5
    total_score += num
  end
  total_score
end

# 2768166558
pp total_points.sort[total_points.size/2]
