# frozen_string_literal: true

module Enumerable
  def my_each
    i = 0
    while self[i]
      yield(self[i])
      i += 1
    end
  end

  def my_each_with_index
    my_each { |e| yield(e, index(e)) }
  end

  def my_select
    result = []
    each do |e|
      result << e if yield(e)
    end
    result
  end

  def my_all?
    my_each do |e|
      return false unless yield(e)
    end
    true
  end

  def my_any?
    my_each do |e|
      return true if yield(e)
    end
    false
  end

  def my_none?
    return true unless block_given?

    my_each do |e|
      return true unless yield(e)
    end
    false
  end

  def my_count(obj = nil)
    count = 0
    my_each do |e|
      count += 1
      return count if obj && count == obj
      return count if block_given? && yield(e)
    end
    return count unless block_given?
  end

  def my_map(&block)
    arr = []
    my_each do |e|
      arr << block.call(e)
    end
    arr
  end

  def my_inject
    memo = self[0]
    my_each do |e|
      memo = yield(memo, e)
    end
    memo
  end
end

# arr = [4, 'hey', 2, 'Hi there!']
arr = [1, 2, 3, 4]

# p arr.my_each
# arr.my_each_with_index { |e, i| p "#{e}, #{i}" }
# p arr.my_select { |e| e.is_a? String }
# p arr.my_all? { |e| e.is_a? String }
# p arr.my_any? { |e| e.is_a? String }
# p arr.my_none? { |e| e == 99 }
# p arr.my_count

double_els = ->(e) { e * 2 }
p arr.my_map { |e| double_els.call(e) }

def multiply_els(arr)
  arr.my_inject { |memo, e| memo * e }
end
p multiply_els([2, 4, 5])
