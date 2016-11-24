require 'pstore'
require_relative 'chess/chess'
require_relative 'chess/board'
require_relative 'chess/piece'
require_relative 'chess/pieces/pawn'
require_relative 'chess/pieces/king'
require_relative 'chess/pieces/queen'
require_relative 'chess/pieces/rook'
require_relative 'chess/pieces/bishop'
require_relative 'chess/pieces/knight'

Player = Struct.new(:color, :pieces, :opponent)

game = Chess.new
game.start_menu
