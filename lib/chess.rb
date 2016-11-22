require_relative 'board'
require_relative 'piece'
require_relative 'pieces/pawn'
require_relative 'pieces/king'
require_relative 'pieces/queen'
require_relative 'pieces/rook'
require_relative 'pieces/bishop'
require_relative 'pieces/knight'

Player = Struct.new(:color, :pieces, :opponent)

class Chess
  attr_reader :players, :board # TEMPORARY ACCESS

  def initialize
    @players = {white: Player.new(:white, []),
                black: Player.new(:black, [])}

    @players[:white].opponent = @players[:black]
    @players[:black].opponent = @players[:white]
    @board = Board.new(@players)
    @current_player = @players[:black]
    @check = false
  end

  def play
    @board.setup
    system("clear")
    @board.print

    until stalemate?
      switch_players
      make_move
      @board.print     
    end
    
    finish_game
  end

  def stalemate?
    @current_player.opponent.pieces.all? { |p| p.moves.empty? }
  end

  def checkmate?
    stalemate? && @current_player.pieces.any? { |p| p.checking? }
  end

  def switch_players
    @current_player = if @current_player.color == :white
                        @current_player = @players[:black]
                      else
                        @current_player = @players[:white]
                      end
  end

  def make_move
    print "Current player: #{@current_player.color.to_s}".ljust(37)
    puts @check ? "CHECK!" : ""
    @check = move
  end

  def move
    while true
      piece, destination = get_move
      
      if piece.nil?
        puts "Illegal move. Try again\n"
        next
      end

      if piece.moves.include?(destination)
        piece.move(destination)
        break
      else
        puts "Illegal move. Try again\n"
      end
    end

    system("clear")

    piece.checking?
  end

  def get_move
    puts "What's your next move? (e.g. d2 d4)"
    mv = gets.chomp.split
    start = mv.first
    piece = if mv.empty? || @board.space(start).nil?
              nil
            elsif @board.space(start).color == @current_player.color
              @board.space(start)
            else
              nil
            end

    destination = mv.last
    [piece, destination]
  end

  def finish_game
    if checkmate?
      puts "CHECKMATE!"
      puts "#{@current_player.color.to_s.capitalize} wins!"
    else
      puts "Stalemate. Game over."
    end
  end
end
