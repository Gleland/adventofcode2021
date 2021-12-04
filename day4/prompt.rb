

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
pp "boards: #{boards}"

def find_winner(boards, numbers)
  winning_board_idx = nil
  winning_row = []
  # 5 is the minimum to get a winning board, so start with 5 draws
  draws = numbers[0..4]
  # draw one number each time, and check each board for a winner
  (4..numbers.size-1).each do |num|
    last_num = num
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
    draws << numbers[num]
  end
end

def calculate_score(board, row, draws)
  if !board.include? row
    pp "column in board"
    board.transpose!
  end
  # remove drawn numbers from board before calculating score
  board.map!{ |row| row.map!{ |n| (draws.include? n) ? 0 : n } }
  #sum each row, and then sum them together
  sum = board.map{ |row| row.reduce(&:+) }.reduce(&:+)
  # score is sum(unmarked numbers) * last number drawn
  return sum * draws[-1]
end

winning_board_idx, winning_row, draws = find_winner(boards, numbers)
score = calculate_score(boards[winning_board_idx], winning_row, draws)
# 3818 too low
# 60368
pp "score: #{score}"

