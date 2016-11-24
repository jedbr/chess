module Pieces
  class Bishop < Piece
    def initialize(color, position, board, owner)
      super(color, position, board, owner)
      @symbol = color == :white ? "♝" : "♗"
    end

    def moves(self_checking = true)
      moves = []

      moves.concat(slash_moves)
      moves.concat(backslash_moves)

      moves = remove_self_checking(moves) if self_checking
      moves
    end
  end
end
