module Pieces
  class Rook < Piece
    def initialize(color, position, board)
      super(color, position, board)
      @symbol = color == :white ? "♖" : "♜"
    end

    def moves
      moves = []
      
      moves.concat(horizontal_moves)
      moves.concat(vertical_moves)
    end
  end
end
