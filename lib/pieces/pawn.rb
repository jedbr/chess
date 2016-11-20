module Pieces
  class Pawn < Piece
    def initialize(color, position, board)
      super(color, position, board)
      @symbol = color == :white ? "♟" : "♙"
      @moved = false
    end

    def moves
      moves = []

      if @color == :white
        moves.push(mv(0, 1),
                   mv(-1, 1),
                   mv(1, 1))
      else
        moves.push(mv(0, -1),
                   mv(-1, -1),
                   mv(1, -1))
      end

      moves = moves.compact
      calculate_collision(moves)
    end

    def calculate_collision(moves)
      available_moves = []

      moves.each_with_index do |m, i|
        space = space(m)

        if i == 0
          if space.nil?
            available_moves << m

            if @moved == false
              first_move = @color == :white ? mv(0, 2) : mv(0, -2)
              space2 = space(first_move)
              available_moves << first_move if space2.nil?
            end
          end
        else
          available_moves << m unless space.nil? ||
                                      space.color == @color
        end
      end

      available_moves
    end
  end
end
