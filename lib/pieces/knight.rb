module Pieces
  class Knight < Piece
    def initialize(color, position, board)
      super(color, position, board)
      @symbol = color == :white ? "♘" : "♞"
    end

    def moves
      moves = []
      moves.push(mv(2, 1),
                 mv(1, 2),
                 mv(2, -1),
                 mv(1, -2),
                 mv(-1, 2),
                 mv(-2, 1),
                 mv(-1, -2),
                 mv(-2, -1))
      
      moves = moves.compact
      calculate_collision(moves)
    end

    def calculate_collision(moves)
      available_moves = []

      moves.each do |m|
        space = @board.position[m[0]][m[1].to_i]

        if space.nil?
          available_moves << m
        else
          available_moves << m unless space.color == @color ||
                                      space.get_type == "King"
        end
      end

      available_moves
    end
  end
end
