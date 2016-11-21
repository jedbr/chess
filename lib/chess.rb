require_relative 'board'
require_relative 'piece'
require_relative 'pieces/pawn'
require_relative 'pieces/king'
require_relative 'pieces/queen'
require_relative 'pieces/rook'
require_relative 'pieces/bishop'
require_relative 'pieces/knight'
require_relative 'exceptions'

Player = Struct.new(:color, :pieces, :opponent)

class Chess
  def initialize
    @players = {white: Player.new(:white, []),
                black: Player.new(:black, [])}
    @board = Board.new(@players)
  end

  def play
    @board.setup
  end
end
