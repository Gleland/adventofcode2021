horz_pos = 0
depth = 0

instructions = File.read('input').split("\n")
instructions.each do |i|
  instr, mov = i.split
  case instr
  when "forward"
    horz_pos += mov.to_i
  when "up"
    depth -= mov.to_i
  when "down"
    depth += mov.to_i
  end
end

puts "answ: #{depth * horz_pos}"
