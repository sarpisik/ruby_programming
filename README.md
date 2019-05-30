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
