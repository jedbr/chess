module Pieces
  class Pawn < Piece
    def initialize(color, position)
      super(color, position)
      @symbol = color == :white ? "♙" : "♟"
      @moved = false
    end

    def moves
      moves = []
      moves.push(mv(0, 1),
                 mv(-1, 1),
                 mv(1, 1))
      moves.select! { |m| m }
      moves << mv(0, 2) if @moved == false
      moves
    end
  end
end
