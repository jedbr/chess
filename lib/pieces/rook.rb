module Pieces
  class Rook < Piece
    def initialize(color, position, board, owner)
      super(color, position, board, owner)
      @symbol = color == :white ? "♜" : "♖"
    end

    def moves(self_checking = true)
      moves = []
      
      moves.concat(horizontal_moves)
      moves.concat(vertical_moves)

      moves = remove_self_checking(moves) if self_checking
      moves
    end
  end
end
