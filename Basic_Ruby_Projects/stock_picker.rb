# frozen_string_literal: true

$get_differences = ->(combi) { combi[1] - combi[0] }

def stock_picker(stocks)
  day_combinations = stocks.combination(2).to_a
  price_differences = day_combinations.map(&$get_differences)
  max_difference_index = price_differences.index(price_differences.max)
  puts day_combinations[max_difference_index]
end

stock_picker([17, 3, 6, 9, 15, 8, 6, 1, 10])
