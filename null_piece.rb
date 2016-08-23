require "singleton"

class NullPiece
  include Singleton

  def moves
  end

  def color
  end

  def to_s
    " "
  end

  def empty?
    true
  end

end
