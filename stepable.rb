module Stepable
  def moves
    moves = []
    move_diffs.each do |(dx, dy)|
      x, y = pos
      move = [x + dx, y + dy]
      moves << move if board.valid_move?(self, move)
    end
    moves
  end
  #
  private
end
