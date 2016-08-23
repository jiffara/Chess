class Piece
  attr_accessor :color, :pos, :board

  def initialize(color, board, pos)
    @color = color
    @board = board
    @pos = pos
  end

  def moves
  end

  def to_s
    symbol
  end

  def valid_moves
  end

  def empty?
    false
  end

  private
  def move_into_check?(to_pos)
    board_copy = board.dup
    board_copy.move(pos, to_pos)
    
  end

end
