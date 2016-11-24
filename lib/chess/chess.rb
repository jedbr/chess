class Chess
  def start_menu
    loop do
      system("clear")
      puts "1. New game"
      puts "2. Load game"
      puts "3. Quit"
      input = gets.chomp
      case input
      when "1"
        new_game
        play
      when "2"
        continue_game if load_game?
      when "3"
        exit
      else
        puts "Unknown command. Type 1, 2 or 3"
        gets
      end
    end
  end

  private

  def new_game
    @players = {white: Player.new(:white, []),
                black: Player.new(:black, [])}

    @players[:white].opponent = @players[:black]
    @players[:black].opponent = @players[:white]
    @board = Board.new(@players)
    @current_player = @players[:black]
    @check = false
  end

  def play
    @board.setup
    system("clear")
    @board.print

    until stalemate?
      switch_players
      make_move
      @board.print     
    end
    
    finish_game
  end

  def load_game?
    filename = filename_to_load
    unless filename.upcase == "SAVES/BACK"
      data = PStore.new(filename)
      data.transaction do
        @players = data[:players]
        @board = data[:board]
        @current_player = data[:current_player]
        @check = data[:check]
      end
      true
    else
      false
    end
  end

  def filename_to_load
    while true
      filename = "saves/"
      print "\nFile to load: "
      filename += gets.chomp
      break if File.exist?(filename) || filename.upcase == "SAVES/BACK"
      puts "File does not exist. Try again. (type 'back' to return to menu)"
    end
    filename
  end

  def continue_game
    switch_players
    system("clear")
    @board.print

    until stalemate?
      switch_players
      make_move
      @board.print     
    end
    
    finish_game
  end

  def stalemate?
    @current_player.opponent.pieces.all? { |p| p.moves.empty? }
  end

  def checkmate?
    stalemate? && @current_player.pieces.any? { |p| p.checking? }
  end

  def switch_players
    @current_player = if @current_player.color == :white
                        @current_player = @players[:black]
                      else
                        @current_player = @players[:white]
                      end
  end

  def make_move
    print "Current player: #{@current_player.color.to_s}".ljust(37)
    puts @check ? "CHECK!" : ""
    @check = move
  end

  def move
    while true
      piece, destination = get_move
      
      if destination == "menu"
        game_menu
        next
      end

      if piece.nil?
        puts "Illegal move. Try again\n"
        next
      end

      if piece.moves.include?(destination)
        piece.move(destination)
        break
      else
        puts "Illegal move. Try again\n"
      end
    end

    system("clear")

    piece.checking?
  end

  def get_move
    puts "What's your next move? (e.g. d2 d4, type 'menu' to open menu)"
    move = gets.chomp.split
    start = move.first
    piece = if move.empty? || @board.space(start).nil?
              nil
            elsif @board.space(start).color == @current_player.color
              @board.space(start)
            else
              nil
            end

    destination = move.last
    [piece, destination]
  end

  def game_menu
    loop do
      puts "1. Back to game"
      puts "2. Save game"
      puts "3. Quit game"
      input = gets.chomp
      case input
      when "1"
        break
      when "2"
        save_game
      when "3"
        exit
      else
        puts "Unknown command. Type 1, 2 or 3"
      end
    end
  end

  def save_game
    Dir.mkdir('saves') unless File.exist?('saves')
    print "Filename: "
    filename = "./saves/#{gets.chomp}"
    data = PStore.new(filename)
    data.transaction do
      data[:players] = @players
      data[:board] = @board
      data[:current_player] = @current_player
      data[:check] = @check
      data.commit
    end
    puts "Game saved.\n"
  end

  def finish_game
    if checkmate?
      puts "CHECKMATE!"
      puts "#{@current_player.color.to_s.capitalize} wins!"
    else
      puts "Stalemate. Game over."
    end
    gets
  end
end
