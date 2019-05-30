# frozen_string_literal: true

def bubble_sort(numbers)
  numbers.each do
    numbers.each_index do |index|
      # Keep iteration if this is not the last number
      next unless numbers[index + 1]

      currentNum = numbers[index]
      nextNum = numbers[index + 1]

      # Swap numbers
      if currentNum > nextNum
        numbers[index] = nextNum
        numbers[index + 1] = currentNum
      end
    end
  end

  puts numbers
end

bubble_sort([200, 4, 3, 78, 2, 0, 2, 100])
