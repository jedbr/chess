module Pieces
  class Pawn < Piece
    def initialize(color, position, board)
      super(color, position, board)
      @symbol = color == :white ? "♙" : "♟"
      @moved = false
    end

    def moves
      moves = []

      moves.push(mv(0, 1),
                 mv(-1, 1),
                 mv(1, 1))

      moves.compact
      moves << mv(0, 2) if @moved == false
      moves
    end

    def calculate_collision(moves)
      false
    end
  end
end
