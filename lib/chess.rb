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
  attr_reader :players, :board # TEMPORARY ACCESS

  def initialize
    @players = {white: Player.new(:white, []),
                black: Player.new(:black, [])}

    @players[:white].opponent = @players[:black]
    @players[:black].opponent = @players[:white]
    @board = Board.new(@players)
    @current_player = @players[:white]
  end

  def play
    @board.setup
  end

  def stalemate?
    @current_player.opponent.pieces.all? { |p| p.moves.empty? }
  end

  def checkmate?
    stalemate? && @current_player.pieces.any? { |p| p.checking? }
  end
end
