vent_map = {}
File.readlines('input', chomp: true).each do |line_seg|
  start_coords, end_coords = line_seg.split(" -> ")
  start_x, start_y = start_coords.split(",").map(&:to_i)
  end_x, end_y = end_coords.split(",").map(&:to_i)
  # only consider when either x or y is changing, not both
  if (start_x - end_x).zero? and (start_y != end_y)
    # change in the y-axis
    # start_x == end_x
    ([start_y, end_y].min..[start_y, end_y].max).each do |y|
      if vent_map["#{start_x},#{y}"].nil? # doesn't exist, initialize
        vent_map["#{start_x},#{y}"] = 1
      else
        # does exist, increment
        vent_map["#{start_x},#{y}"] += 1
      end
    end
  elsif (start_y - end_y).zero? and (start_x != end_x)
    # change in the x-axis
    # start_y == end_y
    ([start_x, end_x].min..[start_x, end_x].max).each do |x|
      if vent_map["#{x},#{start_y}"].nil? # doesn't exist, initialize
        vent_map["#{x},#{start_y}"] = 1
      else
        # does exist, increment
        vent_map["#{x},#{start_y}"] += 1
      end
    end
  end
end

# 8622
pp vent_map.select{ |k,v| v >= 2}.size
