class Piece
  attr_accessor :symbol, :color, :captured

  def initialize(color, position, board)
    @color = color
    @column = position[0]
    @row = position[1].to_i
    @captured = false
    @board = board
  end

  def self.create(color, type, position, board)
    case type
    when :pawn then Pieces::Pawn.new(color, position, board)
    when :king then Pieces::King.new(color, position, board)
    when :queen then Pieces::Queen.new(color, position, board)
    when :rook then Pieces::Rook.new(color, position, board)
    when :bishop then Pieces::Bishop.new(color, position, board)
    when :knight then Pieces::Knight.new(color, position, board)
    end
  end

  def horizontal_moves
    moves1, moves2 = [], []

    ("a"...@column).to_a.reverse_each do |c|
      moves1 << mv(c.ord - @column.ord, 0)
    end

    moves1 = calculate_collision(moves1)

    ((@column.ord + 1).chr.."h").to_a.each do |c|
      moves2 << mv(c.ord - @column.ord, 0)
    end

    moves2 = calculate_collision(moves2)

    moves1 + moves2
  end

  def vertical_moves
    moves1, moves2 = [], []

    (1...@row).to_a.reverse_each do |r|
      moves1 << mv(0, r - @row)
    end

    moves1 = calculate_collision(moves1)

    (@row + 1..8).to_a.each do |r|
      moves2 << mv(0, r - @row)
    end

    moves2 = calculate_collision(moves2)

    moves1 + moves2
  end

  def slash_moves
    moves1, moves2 = [], []

    column = @column.ord
    x_shift = 1
    y_shift = 1

    while column + x_shift <= 104 && @row + y_shift <= 8
      moves1 << mv(x_shift, y_shift)
      x_shift += 1
      y_shift += 1
    end

    moves1 = calculate_collision(moves1)

    x_shift = -1
    y_shift = -1

    while column + x_shift >= 97 && @row + y_shift >= 1
      moves2 << mv(x_shift, y_shift)
      x_shift -= 1
      y_shift -= 1
    end

    moves2 = calculate_collision(moves2)
    
    moves1 + moves2
  end

  def backslash_moves
    moves1, moves2 = [], []

    column = @column.ord
    x_shift = -1
    y_shift = 1

    while column + x_shift >= 97 && @row + y_shift <= 8
      moves1 << mv(x_shift, y_shift)
      x_shift -= 1
      y_shift += 1
    end

    moves1 = calculate_collision(moves1)

    x_shift = 1
    y_shift = -1

    while column + x_shift <= 104 && @row + y_shift >= 1
      moves2 << mv(x_shift, y_shift)
      x_shift += 1
      y_shift -= 1
    end

    moves2 = calculate_collision(moves2)
    
    moves1 + moves2
  end

  def mv(column, row)
    new_position = ""

    new_column = @column.ord + column
    if new_column.between?(97, 104)
      new_position += new_column.chr
    else
      return nil
    end

    new_row = @row + row
    if new_row.between?(1, 8)
      new_position += new_row.to_s
    else
      return nil
    end

    new_position
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
        break
      end
    end

    available_moves
  end

  def checking?
    raise NotImplementedError
  end

  def get_type
    self.class.to_s.split("::").last
  end
end
