module Pieces
  class Knight < Piece
    def initialize(color, position, board)
      super(color, position, board)
      @symbol = color == :white ? "♘" : "♞"
    end

    def moves
      moves = []
      moves.push(mv(2, 1),
                 mv(1, 2),
                 mv(2, -1),
                 mv(1, -2),
                 mv(-1, 2),
                 mv(-2, 1),
                 mv(-1, -2),
                 mv(-2, -1))
      
      moves.compact
    end

    def calculate_collision(moves)
      false
    end
  end
end
