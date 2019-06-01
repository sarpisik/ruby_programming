# frozen_string_literal: true

class Screen
  def initialize; end

  def create_board(score_memory)
    count = 0
    @board = Array.new(3) do
      Array.new(3) do
        if score_memory[count + 1].is_a? Integer
          score_memory[count += 1]
        elsif score_memory[count + 1] == 'X'
          colorize(score_memory[count += 1], 'red')
        else
          colorize(score_memory[count += 1], 'green')
        end
      end
    end
  end

  def colorize(text, color)
    "\e[#{color == 'red' ? 31 : 32}m#{text}\e[0m"
  end

  def set_board_layout
    @board_layout = []
    @board.each_with_index do |row, index|
      @board_layout << [' ', row[0], ' | ', row[1], ' | ', row[2], ' ']
      @board_layout << '---+---+---' if @board[index + 1]
    end
  end

  def print_board(score_memory)
    # Convert hash memory into sub arrays
    create_board(score_memory)

    # Edit created board to a printable board
    set_board_layout

    # Print created board
    puts "\n "
    # If sub array row = '---+---+---', print directly.
    # Else, convert it into string and print.
    @board_layout.each_with_index { |item, index| puts index.odd? ? item : item.join }
  end
end

class Player
  # :name = player name
  # :mark = player mark one of X || O
  # :box = player box selection
  attr_accessor :name, :mark, :box
  def initialize(name)
    self.name = name
  end
end

class Game
  # Constants
  X = 'X'
  O = 'O'

  def initialize
    general_combinations = [1, 2, 3, 4, 5, 6, 7, 8, 9, 1, 4, 7, 2, 5, 8, 3, 6, 9, 1, 5, 9, 3, 5, 7]
    @winning_combinations = general_combinations.each_slice(3).to_a
    @screen = Screen.new

    initialize_game
  end

  def initialize_game
    set_memory
    set_players_names
    set_players_marks
    print_player_marks
    print_board
    render_game
  end

  def set_memory
    @memory = {}
    (1..9).each { |e| @memory[e] = e }
  end

  def set_players_names
    @player1 = Player.new('Player 1')
    @player2 = Player.new('Player 2')
    @current_player = @player1
  end

  def set_players_marks
    loop do
      print_text("Please choose a mark #{@player1.name}, #{X} or #{O} ?")
      @mark = gets.chomp.upcase
      next unless @mark == X || @mark == O

      @player1.mark = @mark
      @player2.mark = @mark == X ? O : X
      break
    end
  end

  def print_player_marks
    print_text("#{@player1.name}'s mark is #{@player1.mark}, #{@player2.name}'s mark is #{@player2.mark}.")
  end

  def print_board
    @screen.print_board(@memory)
  end

  def render_game
    # Loop over the game until finished
    loop do
      get_player_box_selection
      update_memory
      switch_next_player
      print_board

      break if game_end?
    end
    ask_new_game
  end

  def get_player_box_selection
    # Loop over the same question until gets a valid answer.
    loop do
      print_text("Please write number of the box, where you would like to put your mark #{@current_player.name}")
      box = gets.chomp.to_i

      next unless @memory[box] == box

      @current_player.box = box
      break
    end
  end

  def update_memory
    # Save current player's box selection
    @memory[@current_player.box] = @current_player.mark
  end

  def switch_next_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end

  def game_end?
    draw? || player_won?
  end

  def draw?
    unless @memory.any? { |_key, value| value.is_a? Integer }
      print_text('It is a draw!')
      true
    end
    false
  end

  def player_won?
    game_end = false
    @winning_combinations.each do |combination|
      if combination.all? { |box| @memory[box] == @player1.mark }
        print_text("#{@player1.name} Win!")
        game_end = true
      elsif combination.all? { |box| @memory[box] == @player2.mark }
        print_text("#{@player2.name} Win!")
        game_end = true
      else
        game_end
      end
    end
    game_end
  end

  def ask_new_game
    answer = ''
    loop do
      print_text('Would you like to start a new game? (Y) / (N)')
      answer = gets.chomp.downcase
      break if answer == 'y' || answer == 'n'
    end
    answer == 'y' && initialize_game
  end

  def print_text(text)
    puts "\n"
    puts text
  end
end

# Start the game
Game.new
