module Pieces
  class Rook < Piece
    def initialize(color, position)
      super(color, position)
      @symbol = color == :white ? "♖" : "♜"
    end

    def moves
      moves = []
      
      moves << horizontal_moves
      moves << vertical_moves

      moves.flatten!
      moves.select { |m| m }
    end
  end
end
