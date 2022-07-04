code = ["G", "O", "P", "Y"]


=begin Code checks for the pegs/'keys', If the item and index are the same
add + 1 to the black key value in the hash, if the item is in but no the same
index add +1 to white value return the hash,
=end
def check_pegs(code, guess)
  black_white = {black: 0, white: 0}
  guessed = guess.upcase.split("")
  code.each_with_index do |item, i|
    guessed.each_with_index do |element, index|
      black_white[:black] += 1 if item == element && i == index
    end
    black_white[:white] += 1 if guessed.include?(item)
  end 
  black_white[:white] -= black_white[:black]
  black_white
end

p check_pegs(code, "gpyo")