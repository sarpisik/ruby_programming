dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

def substrings(words, dictionary)
  # Key: word
  # Value: repeat count
  results = Hash.new(0)
  words.downcase!

  dictionary.each do |word|
    match = words.scan(word).count
    results[word] = match if match > 0
  end
  results
end


puts substrings("Howdy partner, sit down! How's it going?", dictionary)