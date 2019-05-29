# frozen_string_literal: true

# If the letter is uppercase, return ordinary integers of uppercase letters.
# Else, return the downcase ordinary integers.
def get_letter_range(letter)
  letter =~ /[A-Z]/ ? ('A'.ord..'Z'.ord) : ('a'.ord..'z'.ord)
end

def shift_letter(letter, shift)
  letter_range = get_letter_range(letter)
  letter_shift = letter.ord + shift

  if letter_shift > letter_range.max
    return ((letter_shift - letter_range.max) + (letter_range.min - 1)).chr
  elsif letter_shift < letter_range.min
    return ((letter_shift - letter_range.min) + letter_range.max).chr
  else
    return letter_shift.chr
  end
end

def ceaser_chiper(sentence, shift)
  # If the char is a letter, shift it.
  # Else, return the char
  result = sentence.split('').map do |char|
    char =~ /[a-zA-z]/ ? shift_letter(char, shift) : char
  end
  result.join('')
end

loop do
  puts 'Please enter a sentence'
  sentence = gets.chomp
  puts 'Please enter the shift number'
  shift = gets.chomp

  # Get chiper text
  result = ceaser_chiper(sentence, shift.to_i)

  # Restart the app unless user closes app or answered 'N'
  puts "Your ceaser chiper sentence is: #{result}. Would you like to try new one? (Y) or (N)"
  answer = gets.chomp
  break if answer.downcase == 'n'
end
