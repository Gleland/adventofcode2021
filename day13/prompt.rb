
paper = File.read('input').split("\n")
dots = paper.select{|line| !line.empty? and !line.include? "fold" }.map{ |row| row.split(",").map(&:to_i) }
folds = paper.select{ |line| line.include? "fold" }
largest_row = dots.max_by{ |x| x[1]}[1]
largest_column = dots.max_by{ |x| x[0]}[0]
# create empty grid
grid = Array.new(largest_row+1) { Array.new(largest_column+1,".")}

# populate it with paper's points
dots.each do |col,row|
  grid[row][col] = "#"
end

def fold_grid(grid,fold)
  fold_line = fold.split("=")[-1].to_i
  fold_orientation = fold.split("=")[0][-1]

  if fold_orientation == "y"
    # fold up
    # iterate over each column
    grid[fold_line].map!{|e| "-"}
    grid.each_with_index do |row, r_idx|
      if r_idx == fold_line # we've reached the fold, stop updating
        grid[r_idx].map!{|e| "-"}
        break
      end
      grid[0].each_with_index do |col, c_idx| # assumes all columns have the same size
        mirrored_point = (fold_line - r_idx) + fold_line
        folded_value = grid[mirrored_point][c_idx]
        if folded_value == "#"
          grid[r_idx][c_idx]  = "#"
        else
          # not defined, defer to current value
          # and don't change anything
          1+1
        end
      end
    end
    # now remove the "folded" half of the paper
    (grid.size - fold_line).times do |x|
      grid.pop
    end
  else
    # fold left
    # now it's columns instead of rows

    # iterate over each column
    grid.each{|row| row[fold_line] = "|" }
    grid.each_with_index do |row, r_idx|
      grid[0].each_with_index do |col, c_idx| # assumes all columns have the same size
        if c_idx == fold_line # we've reached the fold, stop updating
          break
        end
        mirrored_point = (fold_line - c_idx) + fold_line
        folded_value = grid[r_idx][mirrored_point]
        if folded_value == "#"
          grid[r_idx][c_idx]  = "#"
        else
          # not defined, defer to current value
          # and don't change anything
          next
        end
        end
    end
    # now remove the "folded" half of the paper
     grid.each do |row|
       row.pop(fold_line+1)
     end
  end
  return grid
end

folded_grid = fold_grid(grid,folds[0])
total_dots = 0
folded_grid.each do |row|
  total_dots += row.count{ |e| e == "#"}
end
# 850
pp "part 1:#{total_dots}"
