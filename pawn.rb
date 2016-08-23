require_relative "piece"

class Pawn < Piece

  def symbol
    "\u265F"
  end

  def moves
    moves = []
    x, y = pos
    forward_steps.each do |steps|
      move = [forward_dir[0] * steps + x, forward_dir[1] + y]
      moves << move if board.valid_move?(self, move)
    end
    side_attacks.each do |attack|
      moves << [attack[0] + x, attack[1] + y] if board.in_bounds?(attack)
    end
    moves
  end

  # def move_diffs
  #   if board(new_pos).is_a?(NullPiece)
  #     [0,1]
  #   elsif board(new_pos)(same_color).
  #     no_move
  #   else
  #     board(new_pos) diff_color
  #     [1,1] [0,1] [-1,1]
  #   end
  # end

  def at_start_row?
    (pos.first == 1 && color == :white) || (pos.first == 6 && color == :black)
  end

  def forward_dir
    color == :white ? [1, 0] : [-1, 0]
  end

  def forward_steps
    return [1, 2] if at_start_row?
    return [1]
  end

  def side_attacks
    step = forward_dir
    possible_attacks = [[step[0], step[1]+1], [step[0], step[1]-1]]
    possible_attacks.select { |(x, y)| !board[[x, y]].empty? && (board[[x, y]].color != color) }
  end
end
