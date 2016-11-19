module Pieces
  class Knight < Piece
    def initialize(color, position)
      super(color, position)
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
      
      moves.select { |m| m }
    end

    def collision?(pos)
      false
    end
  end
end
