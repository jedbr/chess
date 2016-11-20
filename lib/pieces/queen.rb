module Pieces
  class Queen < Piece
    def initialize(color, position, board)
      super(color, position, board)
      @symbol = color == :white ? "♛" : "♕"
    end

    def moves
      moves = []
      
      moves.concat(horizontal_moves)
      moves.concat(vertical_moves)
      moves.concat(slash_moves)
      moves.concat(backslash_moves)
    end
  end
end
