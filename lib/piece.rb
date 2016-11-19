class Piece
  attr_accessor :symbol, :captured

  def initialize(color, position)
    @color = color
    @column = position[0]
    @row = position[1].to_i
    @captured = false
  end

  def self.create(color, type, position)
    case type
    when :pawn then Pieces::Pawn.new(color, position)
    when :king then Pieces::King.new(color, position)
    when :queen then Pieces::Queen.new(color, position)
    when :rook then Pieces::Rook.new(color, position)
    when :bishop then Pieces::Bishop.new(color, position)
    when :knight then Pieces::Knight.new(color, position)
    end
  end

  def horizontal_moves
    moves = []

    columns = ("a"...@column).to_a + ((@column.ord + 1).chr.."h").to_a
    columns.each do |c|
      moves << mv(c.ord - @column.ord, 0)
    end

    moves
  end

  def vertical_moves
    moves = []

    rows = (1...@row).to_a + (@row + 1..8).to_a
    rows.each do |r|
      moves << mv(0, r - @row)
    end

    moves
  end

  def slash_moves
    moves = []

    column = @column.ord
    x_shift = 1
    y_shift = 1

    while column + x_shift <= 104 && @row + y_shift <= 8
      moves << mv(x_shift, y_shift)
      x_shift += 1
      y_shift += 1
    end

    x_shift = -1
    y_shift = -1

    while column + x_shift >= 97 && @row + y_shift >= 1
      moves << mv(x_shift, y_shift)
      x_shift -= 1
      y_shift -= 1
    end
    
    moves
  end

  def backslash_moves
    moves = []

    column = @column.ord
    x_shift = -1
    y_shift = 1

    while column + x_shift >= 97 && @row + y_shift <= 8
      moves << mv(x_shift, y_shift)
      x_shift -= 1
      y_shift += 1
    end

    x_shift = 1
    y_shift = -1

    while column + x_shift <= 104 && @row + y_shift >= 1
      moves << mv(x_shift, y_shift)
      x_shift += 1
      y_shift -= 1
    end
    
    moves
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

    collision?(new_position) ? nil : new_position
  end

  def collision?(pos)
    false
  end

  def checking?
    raise NotImplementedError
  end
end
