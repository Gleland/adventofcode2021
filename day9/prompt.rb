# Find all of the low points on your heightmap. What is the sum of the risk levels of all low points on your heightmap?

# TODO make this recursive, like part2
def smallest_neighbor?(hmap, row, column)
  # top left corner
  if row == 0 and column == 0
    if hmap[row+1][column] > hmap[row][column]
      if hmap[row][column+1] > hmap[row][column]
        return true
      end
    end
  # top right corner
  elsif row == 0 and hmap[row][column+1].nil?
    if hmap[row+1][column] > hmap[row][column]
      if hmap[row][column-1] > hmap[row][column]
        return true
      end
    end
  # bottom left corner
  elsif hmap[row+1].nil? and column == 0
    if hmap[row-1][column] > hmap[row][column]
      if hmap[row][column+1] > hmap[row][column]
        return true
      end
    end
  # bottom right corner
  elsif hmap[row+1].nil? and hmap[row][column+1].nil?
    if hmap[row-1][column] > hmap[row][column]
      if hmap[row][column-1] > hmap[row][column]
        return true
      end
    end
  # top edge
  elsif row == 0 and !hmap[row][column-1].nil? and !hmap[row][column+1].nil?
    if hmap[row][column-1] > hmap[row][column]
      if hmap[row][column+1] > hmap[row][column]
        if hmap[row+1][column] > hmap[row][column]
          return true
        end
      end
    end
  # bottom edge
  elsif hmap[row+1].nil? and !hmap[row][column+1].nil? and !hmap[row][column-1].nil?
    if hmap[row][column-1] > hmap[row][column]
      if hmap[row-1][column] > hmap[row][column]
        if hmap[row][column+1] > hmap[row][column]
          return true
        end
      end
    end
  # left edge
  elsif column == 0 and !hmap[row-1].nil? and !hmap[row+1].nil?
    if hmap[row-1][column] > hmap[row][column]
      if hmap[row+1][column] > hmap[row][column]
        if hmap[row][column+1] > hmap[row][column]
          return true
        end
      end
    end
  # right edge
  elsif hmap[column+1].nil? and !hmap[row+1].nil? and !hmap[row-1].nil?
    if hmap[row-1][column] > hmap[row][column]
      if hmap[row+1][column] > hmap[row][column]
        if hmap[row][column-1] > hmap[row][column]
          return true
        end
      end
    end
  # anywhere else
  else
    if hmap[row-1][column] > hmap[row][column]
    if hmap[row+1][column] > hmap[row][column]
      if hmap[row][column-1] > hmap[row][column]
        if hmap[row][column+1] > hmap[row][column]
          return true
        end
      end
    end
    end
  end
  # made it to the end, not the smallest
  return false
end
risk = 0
risk_vals = []
heightmap = File.readlines('input', chomp:true).map(&:chars)
heightmap.size.times do |row|
  heightmap[0].size.times do |column|
    if smallest_neighbor?(heightmap, row, column)
      risk += heightmap[row][column].to_i + 1
      risk_vals << [heightmap[row][column], row, column]
    end
  end
end
pp risk_vals

# 417
pp risk
