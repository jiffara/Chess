require_relative "board"
require_relative "cursor"
require "colorize"

class Display
  attr_accessor :board, :cursor
  def initialize(board)
    @cursor = Cursor.new([0, 0], board)
    @board = board
  end


  def render(possible_moves = [])
    system("clear")
    puts "  " + ("a".."h").to_a.join("  ")
    board.grid.each_index do |i|
      print 8 - i
      board.grid[i].each_index do |j|
        piece = board[[i, j]]
        if [i, j] == cursor.cursor_pos
          print render_cell(piece, :red)
        else
          if possible_moves.include?([i, j])
            print render_cell(piece, :yellow)
          else
            if (i.even? && j.even?) || (i.odd? && j.odd?)
              print render_cell(piece, :light_black)
            else
              print render_cell(piece, :light_white)
            end
          end
        end
      end
      puts
    end
  end

  def render_cell(piece, background_color)
    return (" " + piece.to_s + " ").colorize(:color => piece.color, :background => background_color)
  end

  def move_cursor
    render
    possible_moves = []
    last_pos = nil
    while true
      input = cursor.get_input
      unless input.nil? #you hit space or return
        possible_moves = board[input].moves unless board[input].empty?
        if board[input].empty? && !last_pos.nil?
          board.move(last_pos, input) if possible_moves.include?(input)
          possible_moves = []
          last_pos = nil
        else
          last_pos = input
        end
      end
      render(possible_moves)
    end
  end
end

d = Display.new(Board.new)
d.move_cursor
