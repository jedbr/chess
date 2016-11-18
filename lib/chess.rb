require_relative 'board'

class Chess
  def initialize
    @board = Board.new
  end

  def play
    @board.setup
  end
end
