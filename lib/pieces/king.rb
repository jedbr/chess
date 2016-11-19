module Pieces
  class King < Piece
    def initialize(color, position, board)
      super(color, position, board)
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

      moves = moves.compact
      moves = calculate_collision(moves)
      remove_self_check(moves)
    end

    def calculate_collision(moves)
      available_moves = []

      moves.each do |m|
        space = @board.position[m[0]][m[1].to_i]

        if space.nil?
          available_moves << m
        else
          available_moves << m unless space.color == @color
        end
      end

      available_moves
    end

    def remove_self_check(moves)
      moves
    end
  end
end
