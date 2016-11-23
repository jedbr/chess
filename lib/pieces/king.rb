module Pieces
  class King < Piece
    def initialize(color, position, board, owner)
      super(color, position, board, owner)
      @symbol = color == :white ? "♚" : "♔"
      @moved = false
      @castling_rooks = []
    end

    def moves(self_checking = true, castling = true)
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
      moves = castling(moves) if castling
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

    def checked?
      @owner.opponent.pieces.any? { |p| p.checking? }
    end

    def checking?
      moves(false, false).any? do |m| 
        s = space(m)
        s && s.type == "King" && s.color != @color
      end
    end
#=begin
    def castling(moves)
      @castling_rooks = []

      unless @moved || checked?
        rooks = @owner.pieces.select { |s| s.type == "Rook" && s.row == @row}
        rooks.each do |r|
          unless r.moved
            if r.column < @column
              if ("b"...@column).all? { |c| @board.position[c][@row].nil? }
                moves = add_castling(moves, mv(-1, 0), r)
              end
            else
              empty_row = ((@column.ord + 1).chr.."g").all? do |c| 
                @board.position[c][@row].nil?
              end

              if empty_row
                moves = add_castling(moves, mv(1, 0), r)
              end
            end
          end
        end
      end

      moves
    end

    def add_castling(moves, move, rook)
      space_checked =  @owner.opponent.pieces.any? do |s|
        s.moves(false).include?(move)
      end

      unless space_checked
        if rook.column == "a"
          moves << mv(-2, 0)
        else
          moves << mv(2, 0)
        end
        @castling_rooks << rook
      end

      moves
    end

    def move(destination)
      if destination == mv(-2, 0)
        @castling_rooks.find { |r| r.column == "a"}.move(mv(-1, 0))
      elsif destination == mv(2, 0)
        @castling_rooks.find { |r| r.column == "h"}.move(mv(1, 0))
      end
      super(destination)
      @moved = true
    end
#=end
  end
end
