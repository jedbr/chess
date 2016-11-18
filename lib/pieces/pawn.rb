require_relative '../pieces'

module Pieces
  class Pawn < Piece
    def initialize(color, position)
      @symbol = color == :white ? "♙" : "♟"
      @position = position
      @captured = false
    end

    def moves(turn)
      moves = []
      moves.push(mv(0, 1),
                 mv(-1, 1),
                 mv(1, 1))
      moves.select! { |m| m }
      moves << mv(0, 2) if turn == 1
      moves
    end
  end
end
