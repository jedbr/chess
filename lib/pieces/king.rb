module Pieces
  class King < Piece
    def initialize(color, position, board, owner)
      super(color, position, board, owner)
      @symbol = color == :white ? "♚" : "♔"
    end

    def moves(self_checking = true)
      moves = []
      moves.push(mv(0, 1),
                 mv(1, 1),
                 mv(1, 0),
                 mv(1, -1),
                 mv(0, -1),
                 mv(-1, -1),
                 mv(-1, 0),
                 mv(-1, 1))

      moves.compact!
      moves = calculate_collision(moves)
      moves = remove_self_checking(moves) if self_checking
      moves
    end

    def calculate_collision(moves)
      available_moves = []

      moves.each do |m|
        space = space(m)

        if space.nil?
          available_moves << m
        else
          available_moves << m unless space.color == @color
        end
      end

      available_moves
    end
  end
end
