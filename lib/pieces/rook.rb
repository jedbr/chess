module Pieces
  class Rook < Piece
    attr_accessor :moved, :row, :column

    def initialize(color, position, board, owner)
      super(color, position, board, owner)
      @symbol = color == :white ? "♜" : "♖"
      @moved = false
    end

    def moves(self_checking = true)
      moves = []
      
      moves.concat(horizontal_moves)
      moves.concat(vertical_moves)

      moves = remove_self_checking(moves) if self_checking
      moves
    end

    def move(destination)
      super(destination)
      @moved = true
    end
  end
end
