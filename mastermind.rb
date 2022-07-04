class Game

  @@color = ['R', 'Y', 'B', 'G', 'P', 'O']
  @@code = []

  def initialize(turns, colors)
    @turns = turns
    @colors = colors
  end 

  def create_code
    4.times do
      @@code.push(@@color[rand(6)])
    end
  end

  def intro
    p "Hello, this is MasterMind, You have to guess a 4 digit code from 6 different colors,the colors can repeat You have 12 turns to guess,Failing to guess before 12 turns will result in a gameover, good luck!."
  end

  def play
    turn = 0
    create_code()
    intro()
    while turn != @turns
      turn += 1
      gameover(turn)
    end
  end

  def player_guess(guess)
    guess.upcase.split("")
  end

  # Code checks for the pegs/'keys', If the item and index are the same
  # add + 1 to the black key value in the hash, if the item is in but no the same
  # index add +1 to white value return the hash,
  
  def check_pegs(guess)
    black_white = {black: 0, white: 0}
    @@code.each_with_index do |item, i|
      guess.each_with_index do |element, index|
        black_white[:black] += 1 if item == element && i == index
      end
      black_white[:white] += 1 if guess.include?(item)
    end 
    black_white[:white] -= black_white[:black]
    black_white
  end

  def gameover(turn)
    if turn >= 12
      p "You lost sadly, The code was #{@@code}, Better luck next time!"
    end
  end
end

new_game = Game.new(12, 6)
new_game.play()

