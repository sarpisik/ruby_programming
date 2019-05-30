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

  p numbers
end

def bubble_sort_by(array)
  array.each do
    array.each_index do |index|
      left = array[index]
      right = array[index + 1]

      next unless right

      result = yield(left, right)
      if result > 0
        array[index] = right
        array[index + 1] = left
      end
    end
  end
  p array
end

bubble_sort([200, 4, 3, 78, 2, 0, 2, 100])

bubble_sort_by(%w[hi hello hey]) do |left, right|
  left.length <=> right.length
end
