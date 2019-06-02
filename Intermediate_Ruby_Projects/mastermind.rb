# frozen_string_literal: true

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

  def generate_code
    code = ''
    4.times { code += rand(7).to_s }
    code
  end

  def check_code(guesses)
    guesses.chars.map.with_index do |char, i|
      next char.red unless @code.include? char
      next char.green if guesses[i] == @code[i]
      next char.red if guesses.scan(char).count > @code.scan(char).count

      char
    end.join('')
  end
end

c = CodeMaker.new('4340')
puts c.check_code('1334')
