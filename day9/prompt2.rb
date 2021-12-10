# What do you get if you multiply together the sizes of the three largest basins?

# already retrived low_points in part one, don't want to rep-aste a bunch of gross code tha tneeds refactoring
# so let's import it directly
low_points = File.readlines('low_points',chomp: true).map{ |r| r.split(',').map{ |n| n.to_i } }

@heightmap = File.readlines('input', chomp:true).map(&:chars)

def recursion(r,c, checked_points)
  # if we've looped past the edges,
  # then dont do anything

  if r.nil? or r < 0 or r > @heightmap.size-1
    return nil
  end
  if c.nil? or c < 0 or c > @heightmap[r].size-1
    return nil
  end
  # found a 9, so this is a border of the basin
  if @heightmap[r][c] == "9"
    return nil
  end
  # make sure we don't accidentally get in a loop
  if checked_points.include? [r,c]
    return nil
  end
  checked_points << [r,c]

  # found a point, let's check its neighbors too
  return [
          [r,c],
          recursion(r-1,c,checked_points),
          recursion(r+1,c,checked_points),
          recursion(r,c-1,checked_points),
          recursion(r,c+1,checked_points)
         ].compact
end

basins = []
low_points.each_with_index do |point,idx|
  basins[idx] =  recursion(point[0],point[1],[]).flatten.size/2
end

# 1148965
pp basins.sort.last(3).reduce(&:*)
