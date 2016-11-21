class Board
  attr_accessor :position, :en_passant, :en_passant_destination

  def initialize(players)
    @position = Hash.new { |h, k| h[k] = Array.new(9) }
    ("a".."h").each do |i|
      @position[i]

    @players = players

    @en_passant = false
    @en_passant_destination = ""
    end
  end

  def row(i)
    row = []
    @position.each_value { |v| row << v[i] }
    row
  end

  def print
    system("clear")
    puts "  ┌────┬────┬────┬────┬────┬────┬────┬────┐"

    (1..8).reverse_each do |i|
      to_print = row(i).map{ |s| s.nil? ? ("  ") : "#{s.symbol} "}.join(" │ ")
      puts "#{i} │ #{to_print} │"
      puts "  ├────┼────┼────┼────┼────┼────┼────┼────┤" unless i == 1
    end

    puts "  └────┴────┴────┴────┴────┴────┴────┴────┘"
    puts "    A    B    C    D    E    F    G    H  \n"
  end

  def setup
    setup_pawns
    setup_figures
  end

  private

  def setup_pawns
    @position.each do |column, row|
      position = column + "2"
      row[2] = Piece.create(:white, :pawn, position, self, @players[:white])
      
      position = column + "7"
      row[7] = Piece.create(:black, :pawn, position, self, @players[:black])
    end
  end

  def setup_figures
    whites = [Piece.create(:white, :rook, "a1", self, @players[:white]),
              Piece.create(:white, :knight, "b1", self, @players[:white]),
              Piece.create(:white, :bishop, "c1", self, @players[:white]),
              Piece.create(:white, :queen, "d1", self, @players[:white]),
              Piece.create(:white, :king, "e1", self, @players[:white]),
              Piece.create(:white, :bishop, "f1", self, @players[:white]),
              Piece.create(:white, :knight, "g1", self, @players[:white]),
              Piece.create(:white, :rook, "h1", self, @players[:white])]
    
    blacks = [Piece.create(:black, :rook, "a8", self, @players[:black]),
              Piece.create(:black, :knight, "b8", self, @players[:black]),
              Piece.create(:black, :bishop, "c8", self, @players[:black]),
              Piece.create(:black, :king, "d8", self, @players[:black]),
              Piece.create(:black, :queen, "e8", self, @players[:black]),
              Piece.create(:black, :bishop, "f8", self, @players[:black]),
              Piece.create(:black, :knight, "g8", self, @players[:black]),
              Piece.create(:black, :rook, "h8", self, @players[:black])]

    @position.each_key do |k|
      @position[k][1] = whites.shift
      @position[k][8] = blacks.shift
    end
  end
end
