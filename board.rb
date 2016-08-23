require_relative "sliding_piece"
require_relative "steping_piece"
require_relative "pawn"
require_relative "null_piece"
require "colorize"

class InvalidMoveError < StandardError
end

class Board
  attr_accessor :grid

  def initialize(populate_on_create = true)
    @grid = Array.new(8) { Array.new(8) }
    populate if populate_on_create
  end

  def populate
    back_row = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
    back_row.each_with_index do |piece, i|
      grid[0][i] = piece.new(:white, self, [0, i])
      # The same as: self.[]=([0, i], piece.new(:white, self, [0, i]))
      grid[7][i] = piece.new(:black, self, [7, i])
      grid[1][i] = Pawn.new(:white, self, [1, i])
      grid[6][i] = Pawn.new(:black, self, [6, i])
    end

    (2..5).each do |i|
    # (1..6).each do |i|
      grid[i].each_index do |j|
        grid[i][j] = NullPiece.instance
      end
    end
  end

  def move(start, end_pos)
    if self[start].empty? &&
      !(self[start].valid_moves.include?(end_pos))
      raise InvalidMoveError.new "That move is invalid."
    end
    piece = self[start]
    self[start] = NullPiece.instance
    piece.pos = end_pos
    unless self[end_pos].empty?
      self.non_kings[self[end_pos].color].delete(self[end_pos])
    end
    self[end_pos] = piece
  end


  def [](pos)
    x, y = pos
    grid[x][y]
  end

  def []=(pos, val)
    row, col = pos
    self.grid[row][col] = val
  end

  def in_bounds?(pos)
    pos.all? { |i| i.between?(0, 7) }
  end

  def valid_move?(start_piece, end_pos)
    if in_bounds?(end_pos)
      destination = self[end_pos]
      return (destination.empty? || destination.color != start_piece.color)
    else
      return false
    end
  end

  def in_check?(color)
    # king_pos = kings[color].pos
    # oppo_color = color == :white ? :black : :white
    # non_kings[oppo_color].any? { |piece| piece.moves.include?(king_pos) }
    king_pos = grid.each_index do |i|
      grid[i].each_index do |j|
        piece = grid[i][j]
        return [i, j] if piece.is_a?(King) && piece.color == color
      end
    end

    grid.each_index do |i|
      grid[i].each_index do |j|
        piece = grid[i][j]
        return true if piece.color != color && piece.moves.include?(king_pos)
      end
    end
    false
  end

  def checkmate?(color)
    if in_check?(color)
      grid.each_index do |i|
        grid[i].each_index do |j|
          piece = grid[i][j]
          if piece.color == color
            return false unless piece.valid_moves.empty?
          end
        end
      end
      return true
    end
    false
  end

  def dup
    new_board = Board.new(false)
    grid.each_index do |i|
      grid[i].each_index do |j|
        piece = self[[i, j]]
        piece_class = piece.class
        unless piece.empty? # grid[i][j]
          new_board[[i, j]] = piece_class.new(piece.color, new_board, [i, j])
        else
          new_board[[i, j]] = NullPiece.instance
        end
      end
    end
    new_board
  end
end
