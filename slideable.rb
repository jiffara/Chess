module Slideable
  def moves
    #TODO: Return all the possible moves
    moves = []
    move_dirs.each do |(dx, dy)|
      moves += grow_unblocked_moves_in_dir(dx, dy)
    end
    moves
  end

  private

  def horizontal_dirs
    [[1, 0], [-1, 0], [0, 1], [0, -1]]
  end

  def diagonal_dirs
    [[1, 1], [-1, 1], [-1, -1], [1, -1]]
  end

  def grow_unblocked_moves_in_dir(dx, dy)
    x, y = pos
    result = []
    multiplier = 1
    move = [x + dx, y + dy]
    while board.valid_move?(self, move)
      result << move
      multiplier += 1
      move = [x + dx * multiplier, y + dy * multiplier]
    end
    result
  end


end
