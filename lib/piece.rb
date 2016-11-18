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
    end
  end

  def moves
    raise NotImplementedError
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
