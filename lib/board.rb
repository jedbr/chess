class Board
  attr_accessor :position

  def initialize
    @position = Hash.new { |h, k| h[k] = Array.new(9) }
    ("a".."h").each do |i|
      @position[i]
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
    puts "    A    B    C    D    E    F    G    H  "
  end

  def setup
    setup_pawns
    setup_figures
  end

  private

  def setup_pawns
    @position.each do |c, r|
      position = c + "2"
      r[2] = Piece.create(:white, :pawn, position)
      position = c + "7"
      r[7] = Piece.create(:black, :pawn, position)
    end
  end

  def setup_figures
    whites = [Piece.create(:white, :rook, "a1"),
              Piece.create(:white, :knight, "b1"),
              Piece.create(:white, :bishop, "c1"),
              Piece.create(:white, :queen, "d1"),
              Piece.create(:white, :king, "e1"),
              Piece.create(:white, :bishop, "f1"),
              Piece.create(:white, :knight, "g1"),
              Piece.create(:white, :rook, "h1")]
    
    blacks = [Piece.create(:black, :rook, "a8"),
              Piece.create(:black, :knight, "b8"),
              Piece.create(:black, :bishop, "c8"),
              Piece.create(:black, :king, "d8"),
              Piece.create(:black, :queen, "e8"),
              Piece.create(:black, :bishop, "f8"),
              Piece.create(:black, :knight, "g8"),
              Piece.create(:black, :rook, "h8")]

    @position.each_key do |k|
      @position[k][1] = whites.shift
      @position[k][8] = blacks.shift
    end
  end
end
