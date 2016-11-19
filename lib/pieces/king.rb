module Pieces
  class King < Piece
    def initialize(color, position)
      super(color, position)
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

      moves.select { |m| m }
    end

    def collision?(pos)
      # TODO
      false
    end
  end
end
