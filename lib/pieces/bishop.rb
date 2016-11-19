module Pieces
  class Bishop < Piece
    def initialize(color, position)
      super(color, position)
      @symbol = color == :white ? "♗" : "♝"
    end

    def moves
      moves = []

      moves << slash_moves
      moves << backslash_moves

      moves.flatten!
      moves.select { |m| m }
    end
  end
end
