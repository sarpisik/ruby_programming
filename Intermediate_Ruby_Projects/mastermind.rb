# frozen_string_literal: true

def generate_code
  code = ''
  4.times { code += rand(1..6).to_s }
  code
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
  def initialize(code = false)
    @code = code || generate_code
    puts @code
  end

  def check_code(guess)
    guess.chars.map.with_index do |char, i|
      next char.red unless @code.include? char
      next char.green if guess[i] == @code[i]
      next char.red if guess.scan(char).count > @code.scan(char).count

      char
    end.join('')
  end
end

class CodeBreaker
  def initialize(player = false)
    @machine = player
  end

  def get_guess
    return get_machine_guess unless @machine

    get_player_guess
  end

  def get_machine_guess
    generate_code
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
    @guess.chars.all? { |char| char.to_i > 0 && char.to_i < 7 }
  end
end

c = CodeMaker.new('4340')
puts c.check_code('1334')

b = CodeBreaker.new(true)
puts b.get_guess
