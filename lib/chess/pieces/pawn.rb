module Pieces
  class Pawn < Piece
    def initialize(color, position, board, owner)
      super(color, position, board, owner)
      @symbol = color == :white ? "♟" : "♙"
      @moved = false
    end

    def moves(self_checking = true)
      moves = []

      if @color == :white
        moves.push(translate_move(0, 1),
                   translate_move(-1, 1),
                   translate_move(1, 1))
      else
        moves.push(translate_move(0, -1),
                   translate_move(-1, -1),
                   translate_move(1, -1))
      end

      moves.compact!
      moves = calculate_collision(moves)
      moves = remove_self_checking(moves) if self_checking
      moves
    end

    def move(destination)

      if @moved == false
        if destination == translate_move(0, 2)
          @board.en_passant = true
          @board.en_passant_destination = translate_move(0, 1)
        elsif destination == translate_move(0, -2)
          @board.en_passant = true
          @board.en_passant_destination = translate_move(0, -1)
        else
          @board.en_passant = false
        end
        @moved = true
        update_position(destination)

      elsif @board.en_passant == true &&
            destination == @board.en_passant_destination

        update_position(destination)
        if @color == :white
          space(translate_move(0, -1)).destroy
        else
          space(translate_move(0, 1)).destroy
        end
        @board.en_passant = false
      else
        @board.en_passant = false
        update_position(destination)
      end

      if @color == :white
        promote if @row == 8
      else
        promote if @row == 1
      end
    end

    def checking?
      not_checking = [translate_move(0, 2),
                      translate_move(0, 1),
                      translate_move(0, -2),
                      translate_move(0, -1)]
      
      (moves(false) - not_checking).any? do |m| 
        s = space(m)
        true if s && s.type == "King" && s.color != @color
      end
    end

    private

    def calculate_collision(moves)
      available_moves = []

      moves.each_with_index do |m, i|
        space = space(m)

        if i == 0
          if space.nil?
            available_moves << m

            if @moved == false
              first_move = if @color == :white
                             translate_move(0, 2)
                           else
                             translate_move(0, -2)
                           end
                           
              available_moves << first_move if space(first_move).nil?
            end
          end
        elsif @board.en_passant && m == @board.en_passant_destination
          available_moves << m
        else
          available_moves << m unless space.nil? ||
                                      space.color == @color 
        end
      end

      available_moves
    end

    def promote
      @board.print
      puts "Choose promotion (type: queen, rook, bishop or knight): "
      while type = gets.chomp.to_sym
        case type
        when :queen, :rook, :bishop, :knight
          self.destroy
          @board.position[@column][@row] = 
            Piece.create(@color, type, @position, @board, @owner)
          break
        else
          puts "Invalid input. Try again."
          puts "Choose promotion (type: queen, rook, bishop or knight): "
        end
      end
    end
  end
end
