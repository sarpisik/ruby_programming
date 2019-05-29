### RUBY PROGRAMMING EXERCISES

My ruby programming projects from The Odin Project's [curriculum](https://www.theodinproject.com/courses/ruby-programming)

## Basic Ruby Projects

# Caesar Cipher

From Wikipedia:

In cryptography, a Caesar cipher, also known as Caesar’s cipher, the shift cipher, Caesar’s code or Caesar shift, is one of the simplest and most widely known encryption techniques. It is a type of substitution cipher in which each letter in the plaintext is replaced by a letter some fixed number of positions down the alphabet. For example, with a left shift of 3, D would be replaced by A, E would become B, and so on. The method is named after Julius Caesar, who used it in his private correspondence.

Simple, it takes in a string and the shift factor and then outputs the modified string:

```ruby
  > caesar_cipher("What a string!", 5)
  => "Bmfy f xywnsl!"
```

# Stock Picker

It takes in an array of stock prices, one for each hypothetical day. It returns a pair of days representing the best day to buy and the best day to sell.

```ruby
  > stock_picker([17,3,6,9,15,8,6,1,10])
  => [1,4]  # for a profit of $15 - $3 == $12
```
