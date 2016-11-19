module Pieces
  class King < Piece
    def initialize(color, position, board)
      super(color, position, board)
      @symbol = color == :white ? "♔" : "♚"
    end

    def moves
      moves = []
      moves.push(mv(0, 1),
                 mv(1, 1),
                 mv(1, 0),
                 mv(1, -1),
                 mv(0, -1),
                 mv(-1, -1),
                 mv(-1, 0),
                 mv(-1, 1))

      moves.compact
    end

    def calculate_collision(moves)
      false
    end
  end
end
