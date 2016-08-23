require_relative "piece"
require_relative "slideable"

class Bishop < Piece
  include Slideable

  def symbol
    "\u265D"
  end

  protected
  def move_dirs
    diagonal_dirs
  end
end

class Rook < Piece
  include Slideable

  def symbol
    "\u265C"
  end

  protected
  def move_dirs
    horizontal_dirs
  end
end

class Queen < Piece
  include Slideable

  def symbol
    "\u265B"
  end

  protected
  def move_dirs
    horizontal_dirs + diagonal_dirs
  end
end
