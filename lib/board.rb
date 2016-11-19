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

    (1..8).each do |i|
      to_print = row(i).map{ |s| s.nil? ? ("  ") : "#{s.symbol} "}.join(" │ ")
      puts "#{9 - i} │ #{to_print} │"
      puts "  ├────┼────┼────┼────┼────┼────┼────┼────┤" unless i == 8
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

  end
end
