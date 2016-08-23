require_relative "piece"
require_relative "stepable"

class King < Piece
  include Stepable

  def symbol
    "\u265A"
  end

  protected
  def move_diffs
    [[0, 1], [1, 1], [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 1], [-1, 0]]
  end
end

class Knight < Piece
  include Stepable

  def symbol
    "\u265E"
  end

  protected
  def move_diffs
    [[2, 1], [1, 2], [-1, 2], [-2, 1], [-2, -1], [-1, -2], [1, -2], [2, -1]]
  end
end
