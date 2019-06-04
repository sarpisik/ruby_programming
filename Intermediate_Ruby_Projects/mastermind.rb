# frozen_string_literal: true

module Helpers
  def generate_number
    rand(1..6).to_s
  end

  def generate_code
    code = ''
    4.times { code += generate_number }
    code
  end
end

class String
  def red
    "\e[31m#{self}\e[0m"
  end

  def green
    "\e[32m#{self}\e[0m"
  end
end

class CodeMaker
  include Helpers

  def initialize(player_code = false)
    @secret_code = player_code || generate_code
  end

  def check_code(code)
    repeated_white_digits = 0
    digits_guessed = code[:digits_guessed]
    digits_validations = code[:order_digits]

    digits_guessed.each_char.with_index do |digit, i|
      # If this is not one the code digits, make color red.
      unless @secret_code.include? digit
        digits_validations[i] = -1
        next
      end

      # If this is one of the code digits and in the correct place, make color green.
      next digits_validations[i] = 1 if digits_guessed[i] == @secret_code[i]

      # If this is one of the code digits but in the wrong place and repeated more than code digits...
      if digits_guessed.scan(digit).count > @secret_code.scan(digit).count
        repeated_white_digits += 1
        # Make color red. Until the repeated digits and the code digits counts are equal.
        next digits_validations[i] = -1 if (digits_guessed.scan(digit).count - repeated_white_digits) >= @secret_code.scan(digit).count

        next digits_validations[i] = 0
      else
        # Else, this is one of the code digits but in the wrong place
        next digits_validations[i] = 0
      end
    end

    # Return validated guessed digits.
    code
  end

  def get_secret_code
    @secret_code
  end
end

class CodeBreaker
  include Helpers

  def initialize(no_human = false)
    @machine_player = no_human
    @red_digits_memo = [] if @machine_player
  end

  def get_guess(code)
    # If code breaker is human, get human guess.
    # Else, get AI guess.
    code[:digits_guessed] = @machine_player ? get_machine_guess(code) : get_player_guess

    # Return guessed digits
    code
  end

  def get_machine_guess(code)
    # If this is initial guess, generate digits.
    # Else, use below logic to make new guess.
    return generate_code if code[:digits_guessed].empty?

    # Prior round guessed digits.
    digits_guessed = code[:digits_guessed].chars
    # Validation of the digits_guessed
    digits_validated = code[:order_digits]
    # Merge memory of red digits with fresh red digits.
    @red_digits_memo.concat(
      digits_guessed.select.with_index do |_digit, i|
        digits_validated[i] < 0
      end
    )

    digits_guessed.map.with_index do |digit, i|
      case digits_validated[i]
        # If this is a red digit, replace with new generated digit.
      when -1
        next digit = get_new_digit
        # If this is a white digit...
      when 0
        # look for next white digit to swipe places.
        next_digit_to_replace = digits_guessed.find.with_index do |next_digit, next_digit_i|
          if digits_validated[next_digit_i] == 0 && next_digit_i > i
            digits_guessed[next_digit_i] = digit
            break next_digit
          end
        end
        # If there none white digit left to swipe, so nothing.
        next digit unless next_digit_to_replace

        # Else, swipe the digits.
        next next_digit_to_replace
      else
        # If this is a green digit, do nothing.
        next digit
      end
    end.join('')
  end

  def get_new_digit
    # Generate and return a new digit which is not a red digit already.
    while new_digit = generate_number
      break new_digit unless @red_digits_memo.include? new_digit
    end
  end

  def get_player_guess
    loop do
      ask_guess
      break if guess_valid?
    end
    @guess
  end

  def ask_guess
    puts 'Enter 4 numbers within the range of 1 to 6 to break the secret code!'
    @guess = gets.chomp
  end

  def guess_valid?
    @guess.length == 4 && @guess.chars.all? { |char| char.to_i > 0 && char.to_i < 7 }
  end
end

class Game
  def initialize
    display_welcome
    render_game
  end

  def display_welcome
    puts "\n"
    puts '*************************************************'
    puts '******** Welcome To The Mastermind Game! ********'
    puts '*************************************************'
    puts '================================================='
  end

  def render_game
    @code = {
      digits_guessed: [],
      order_digits: []
    }
    get_player_role
    display_instructions
    instantiate_roles

    @turns = 6

    loop do
      display_remaining_turns
      display_guess_request
      display_guessed_digits
      get_code_validation
      give_hint
      break if game_ended?
    end

    new_game?
  end

  def get_player_role
    loop do
      puts "\nWhich role would you like to play as?"
      puts 'Code Maker (1) || Code Breaker (2)'

      @player_role = gets.chomp.to_i
      break if @player_role == 1 || @player_role == 2
    end
  end

  def display_instructions
    puts "\n"
    puts '*************************************************'
    puts '****************  Instructions  *****************'
    puts '*************************************************'
    puts '================================================='

    @player_role == 1 ? code_maker_instructions : code_breaker_instructions

    puts '3. Each time you enter your guesses, the computer'
    puts '   will give you some hints on whether your guess'
    puts '   had correct digit, incorrect digits or correct'
    puts "   digits that are in the incorrect position.\n  "
    puts '*************************************************'
    puts '*************   GUIDES TO HINTS   ***************'
    puts '*************************************************'
    puts '================================================='
    puts '1. If you get a digit correct and it is in the   '
    puts '   correct position, the digit will be colored   '
    puts "   #{'green'.green}."
    puts '2. If you get a digit correct but in the wrong   '
    puts '   position, the digit will be colored white.     '
    puts '3. If you get the digit incorrect, the digit will'
    puts "   be colored #{'red'.red}.\n "
    puts 'For example:'
    puts 'If the secret code is:'
    puts '1523'
    puts 'and your guess was:'
    puts '1562'
    puts 'You will see the following result:'
    puts "#{'15'.green}#{'6'.red}2"
  end

  def code_maker_instructions
    puts '1. You will create a 4 digits secret code. The   '
    puts '   code must be between 1 to 6.'
    puts '2. The AI/Computer will have 5 guesses to try and'
    puts '   crack your secret code. You win if your secret'
    puts '   code is not cracked'
  end

  def code_breaker_instructions
    puts '1. You have to break the secret code in order to '
    puts '   win the game'
    puts '2. You are given 5 guesses to break the code. The'
    puts '   code ranges between 1 to 6. A number can be   '
    puts '   repeated more than once!'
  end

  def instantiate_roles
    if @player_role == 1
      get_player_secret_code
      @code_maker = CodeMaker.new(@player_secret_code)
      @code_breaker = CodeBreaker.new(true)
    else
      @code_maker = CodeMaker.new
      @code_breaker = CodeBreaker.new
    end
  end

  def get_player_secret_code
    loop do
      puts 'Enter 4 numbers within the range of 1 to 6 to make the secret code!'
      @player_secret_code = gets.chomp
      break if secret_code_valid?
    end
  end

  def secret_code_valid?
    @player_secret_code.length == 4 && @player_secret_code.chars.all? { |char| char.to_i > 0 && char.to_i < 7 }
  end

  def display_remaining_turns
    puts "\n"
    puts "You have #{@turns -= 1} guesses remaining."
  end

  def display_guess_request
    @code = @code_breaker.get_guess(@code)
  end

  def display_guessed_digits
    puts "\n"
    puts 'Your guess:'
    puts @code[:digits_guessed]
  end

  def get_code_validation
    @code = @code_maker.check_code(@code)
  end

  def give_hint
    result = refactor_code_validation
    puts "\n"
    puts 'Hints:'
    puts result
  end

  def refactor_code_validation
    @code[:digits_guessed].chars.map.with_index do |char, index|
      case @code[:order_digits][index]
      when -1
        next char.red
      when 1
        next char.green
      else
        char
      end
    end.join('')
  end

  def game_ended?
    @code_broken = @code[:order_digits].all? { |digit| digit == 1 }
    turns_out = @turns < 1
    @code_broken || turns_out
  end

  def new_game?
    if @code_broken
      puts "\nThe code breaker has cracked the secret code! The code breaker wins!"
    else
      secret_code = @code_maker.get_secret_code
      puts "\nThe secret code was #{secret_code}. The code maker wins!"
    end

    puts "\n"
    puts 'Would you like to Play again? Y/N?'
    answer = gets.chomp.downcase
    return render_game if answer == 'y'

    puts 'Thanks for playing!'
  end
end

Game.new
