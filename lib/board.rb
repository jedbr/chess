require_relative 'pieces'

class Board
  attr_accessor :column

  def initialize
    @column = Hash.new { |h, k| h[k] = Array.new(8) }
    ("a".."h").each do |i|
      @column[i.to_sym]
    end
  end

  def row(i)
    row = []
    @column.each_value { |v| row << v[i] }
    row
  end

  def setup

  end
end
