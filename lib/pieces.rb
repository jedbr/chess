require_relative 'pieces/pawn'

class Piece
  attr_accessor :position, :symbol, :captured

  def self.create(color, type, position)
    case type
    when :pawn then Pieces::Pawn.new(color, position)
    end
  end

  def moves
    raise NotImplementedError
  end

  def mv(column, row)
    pos = @position.to_s
    if (pos[0].ord + column).between?(97, 104)
      pos[0] = (pos[0].ord + column).chr
    else
      return nil
    end

    if (pos[1].to_i + row).between?(1, 8)
      pos[1] = (pos[1].to_i + row).to_s
    else
      return nil
    end

    pos.to_sym
  end

  def checking?
    raise NotImplementedError
  end

  def capture(target)
    @position = target.position
    target.destroy
  end

  def destroy
    @captured = true
    @position = nil
  end
end
