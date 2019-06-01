# RUBY PROGRAMMING EXERCISES

My ruby programming projects from The Odin Project's [curriculum](https://www.theodinproject.com/courses/ruby-programming)

## Basic Ruby Projects

### Caesar Cipher

From Wikipedia:

In cryptography, a Caesar cipher, also known as Caesar’s cipher, the shift cipher, Caesar’s code or Caesar shift, is one of the simplest and most widely known encryption techniques. It is a type of substitution cipher in which each letter in the plaintext is replaced by a letter some fixed number of positions down the alphabet. For example, with a left shift of 3, D would be replaced by A, E would become B, and so on. The method is named after Julius Caesar, who used it in his private correspondence.

Simple, it takes in a string and the shift factor and then outputs the modified string:

```ruby
  > caesar_cipher("What a string!", 5)
  => "Bmfy f xywnsl!"
```

### Stock Picker

It takes in an array of stock prices, one for each hypothetical day. It returns a pair of days representing the best day to buy and the best day to sell.

```ruby
  > stock_picker([17,3,6,9,15,8,6,1,10])
  => [1,4]  # for a profit of $15 - $3 == $12
```

### Substrings

It takes a word as the first argument and then an array of valid substrings (from dictionary) as the second argument. It returns a hash listing each substring (case insensitive) that was found in the original string and how many times it was found.

```ruby
  > dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]
  > substrings("Howdy partner, sit down! How's it going?", dictionary)
  => { "down" => 1, "how" => 2, "howdy" => 1,"go" => 1, "going" => 1, "it" => 2, "i" => 3, "own" => 1,"part" => 1,"partner" => 1,"sit" => 1 }
```

### Bubble Sort

#### bubble_sort

It takes an array and returns a sorted array. It use the bubble sort methodology without using the Array.sort method.

```ruby
  > bubble_sort([4,3,78,2,0,2])
  => [0,2,2,3,4,78]
```

#### bubble_sort_by

A similar to bubble_sort method which sorts an array by accepting a block.

```ruby
  > bubble_sort_by(["hi","hello","hey"]) do |left,right|
  >   left.length <=> right.length
  > end
  => ["hi", "hey", "hello"]
```

### Enumerable Methods

Custom methods in Enumerable module.

```ruby
  > module Enumerable
  >   def my_each
  >     i = 0
  >     while self[i]
  >       yield(self[i])
  >       i += 1
  >     end
  >   end
  > end
```

## Intermediate Ruby Projects

Object Oriented Programming Projects:

### Tic Tac Toe

A command line version of tic tac toe game. It involves a couple of players, a simple board, checking for victory in a game loop…
See [Wikipedia](http://en.wikipedia.org/wiki/Tic-tac-toe) if you can’t remember the rules, or if you haven’t ever played.

[Click here to play](https://repl.it/@sarpisik/Tic-Tac-Toe-Game)
