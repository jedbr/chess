module Pieces
  class Bishop < Piece
    def initialize(color, position, board, owner)
      super(color, position, board, owner)
      @symbol = color == :white ? "♝" : "♗"
    end

    def moves
      moves = []

      moves.concat(slash_moves)
      moves.concat(backslash_moves)
    end
  end
end
