require_relative 'board'
require_relative 'piece'
require_relative 'pieces/pawn'
require_relative 'pieces/king'
require_relative 'pieces/queen'

class Chess
  def initialize
    @board = Board.new
  end

  def play
    @board.setup
  end
end
