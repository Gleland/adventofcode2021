# Figure out which board will win last. Once it wins, what would its final score be?
#
boards = []
# just get the numbers
numbers = File.readlines('input')[0].split(",").map(&:to_i)
# now get the boards
idx = 0
File.readlines('input')[2..].each_with_index do |row|
  boards[idx] = [] if boards[idx].nil?
  if row == "\n"
    idx += 1
    next
  end
  boards[idx] << row.split(" ").map(&:to_i)
end

def find_winner(boards, numbers, draws)
  winning_board_idx = nil
  winning_row = []
  # 5 is the minimum to get a winning board, so start with 5 draws
  # if not already defined
  draws = numbers[0..4] if draws.nil?
  # draw one number each time, and check each board for a winner
  (4..numbers.size-1).each do |num|
    boards.each_with_index do |board,idx|
      board.each do |row|
        if (row - draws).empty?
            # row matched
            winning_board_idx = idx
            winning_row = row
            return winning_board_idx, winning_row, draws
        end
      end
      if winning_board_idx.nil?
        # transpose to check columns too
        board.transpose.each do |row|
          if (row - draws).empty?
            # column matched
            winning_board_idx = idx
            winning_row = row
            return winning_board_idx, winning_row, draws
          end
        end
      end
    end
    # no winning board found, draw and try again
    # if new numbers are still available
    draws << numbers[num] if !(numbers - draws).empty?
  end
end

def calculate_score(board, row, draws)
  if !board.include? row
    board = board.transpose
  end
  # replace drawn numbers with 0 before calculating score
  board.map!{ |row| row.map!{ |n| (draws.include? n) ? 0 : n } }
  # sum each row, and then sum rows together
  sum = board.map{ |row| row.reduce(&:+) }.reduce(&:+)
  # score is sum(unmarked numbers) * last number drawn
  return sum * draws[-1]
end

score = -1
winning_boards = 0
starting_size = boards.size

# calculated through until the last winning board
while winning_boards < (starting_size)
  winning_board_idx, winning_row, draws = find_winner(boards, numbers, draws)
  # skip score calculation until it's necessary
  if winning_boards == starting_size - 1
    score = calculate_score(boards[winning_board_idx], winning_row, draws)
  end
  boards.reject!.with_index{ |b,i| i == winning_board_idx }
  winning_boards += 1
end

# 17435
pp "score: #{score}"
