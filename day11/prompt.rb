require 'set'
# Given the starting energy levels of the dumbo octopuses in your cavern, simulate 100 steps.
# How many total flashes are there after 100 steps?

@grid = File.readlines('input',chomp: true).map{ |r| r.chars.map(&:to_i) }
total_flashes = 0

def find_neighbors(r,c)
  potential_neighbors = [
    [r-1,c-1], # above-left
    [r-1,c], # above
    [r-1,c+1], # above-right
    [r,c-1], # left
    [r,c+1], # right
    [r+1,c-1], # below-left
    [r+1,c], # below
    [r+1,c+1], # below-right
  ]
  neighbors = []
  potential_neighbors.each do |r,c|
    if r.nil? or r < 0 or r >= @grid.size or @grid[r].nil?
       next
    end
    if c.nil? or c < 0 or c >= @grid[r].size
       next
    end
    if @grid[r][c].nil?
      # not a valid point
      next
    end
    if @grid[r][c] <= 9
      # only include if it can flash
      neighbors << [r,c]
    end
  end
  neighbors
end


def increment_neighbors(neighbors)
  neighbors.each do |r,c|
    @grid[r][c] += 1
  end
end

100.times do |step|
  pp "Step #{step+1}"

  # increment all by one
  @grid.map!{ |row| row.map!{ |v| v+1 } }

  more_flashes_to_count = true
  @previously_flashed_octopi = []
  while more_flashes_to_count
    # flashing octopi now includes affected neighbors
    # find newly flashed octopi and drop those already done
    newly_flashed_octopi = []
      @grid.each_with_index do |row, i|
      row.each_with_index do |col, j|
        if col > 9
          newly_flashed_octopi << [i,j]
        end
      end
    end
    newly_flashed_octopi = newly_flashed_octopi - @previously_flashed_octopi
    @previously_flashed_octopi += newly_flashed_octopi
    if newly_flashed_octopi.empty?
       more_flashes_to_count = false
    end
    # find affected neighbors
    affected_neighbors = []
    newly_flashed_octopi.each do |r,c|
      neigh = find_neighbors(r,c)
      affected_neighbors += neigh
    end
    # increment affected neighbors
    affected_neighbors.each do |r,c|
      @grid[r][c] += 1
    end
    if newly_flashed_octopi.empty?
      more_flashes_to_count = false
    end
  end
  # count additional flashes
  @grid.each do |row|
   row.each do |v|
     if v > 9
       total_flashes += 1
     end
   end
  end
  # increment total flashes
  @grid.map!{ |row| row.map!{ |v| v > 9 ? 0 : v } }
end
# 1741
pp total_flashes
