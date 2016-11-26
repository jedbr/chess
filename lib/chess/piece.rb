class Piece
  attr_accessor :symbol, :color, :position

  def self.create(color, type, position, board, owner)
    piece = 
      case type
      when :pawn then Pieces::Pawn.new(color, position, board, owner)
      when :king then Pieces::King.new(color, position, board, owner)
      when :queen then Pieces::Queen.new(color, position, board, owner)
      when :rook then Pieces::Rook.new(color, position, board, owner)
      when :bishop then Pieces::Bishop.new(color, position, board, owner)
      when :knight then Pieces::Knight.new(color, position, board, owner)
      end

    board.assign_to(position, piece)
    owner.pieces << piece
  end

  def initialize(color, position, board,  owner)
    @color = color
    @position = position
    @column = position[0]
    @row = position[1].to_i
    @board = board
    @owner = owner
  end

  def move(destination)
    @board.en_passant = false
    update_position(destination)
  end

  def checking?
    moves(false).any? do |m| 
      s = space(m)
      s && s.type == "King" && s.color != @color
    end
  end

  protected

  def type
    self.class.to_s.split("::").last
  end

  def destroy
    @board.assign_to(@position, nil)
    @owner.pieces.delete(self)
  end

  def restore
    @board.assign_to(@position, self)
    @owner.pieces << self
  end

  private

  def update_position(destination)
    space(destination).destroy unless space(destination).nil?
    @board.assign_to(@position, nil)

    @position = destination
    @column = @position[0]
    @row = @position[1].to_i

    @board.assign_to(@position, self)
  end

  def space(coords)
    @board.position[coords[0]][coords[1].to_i]
  end

  def horizontal_moves
    moves1, moves2 = [], []

    ("a"...@column).to_a.reverse_each do |c|
      moves1 << translate_move(c.ord - @column.ord, 0)
    end

    moves1 = calculate_collision(moves1)

    ((@column.ord + 1).chr.."h").to_a.each do |c|
      moves2 << translate_move(c.ord - @column.ord, 0)
    end

    moves2 = calculate_collision(moves2)

    moves1 + moves2
  end

  def vertical_moves
    moves1, moves2 = [], []

    (1...@row).to_a.reverse_each do |r|
      moves1 << translate_move(0, r - @row)
    end

    moves1 = calculate_collision(moves1)

    (@row + 1..8).to_a.each do |r|
      moves2 << translate_move(0, r - @row)
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
      moves1 << translate_move(x_shift, y_shift)
      x_shift += 1
      y_shift += 1
    end

    moves1 = calculate_collision(moves1)

    x_shift = -1
    y_shift = -1

    while column + x_shift >= 97 && @row + y_shift >= 1
      moves2 << translate_move(x_shift, y_shift)
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
      moves1 << translate_move(x_shift, y_shift)
      x_shift -= 1
      y_shift += 1
    end

    moves1 = calculate_collision(moves1)

    x_shift = 1
    y_shift = -1

    while column + x_shift <= 104 && @row + y_shift >= 1
      moves2 << translate_move(x_shift, y_shift)
      x_shift += 1
      y_shift -= 1
    end

    moves2 = calculate_collision(moves2)
    
    moves1 + moves2
  end

  def translate_move(column, row)
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
      space = space(m)

      if space.nil?
        available_moves << m
      else
        available_moves << m unless space.color == @color
        break
      end
    end

    available_moves
  end

  def remove_self_checking(moves_to_filter)
    safe_moves = []

    moves_to_filter.each do |m|
      backup = space(m)
      space(m).destroy unless backup.nil?
      @board.assign_to(m, self)
      @board.assign_to(@position, nil)

      safe_moves << m unless @owner.opponent.pieces.any? { |p| p.checking? }

      backup.nil? ? @board.assign_to(m, nil) : backup.restore
      @board.assign_to(@position, self)
    end

    safe_moves
  end
end
