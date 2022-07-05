# frozen_string_literal: true

# main class for the game
class Game
  @@color = %(RGBPOY)
  @@code = []
  @@guesses = {}
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
    p 'Hello, this is MasterMind, You have to guess a 4 digit code from 6 different colors,the colors can repeat You have 12 turns to guess,Failing to guess before 12 turns will result in a gameover, good luck!.'
    p 'There are 6 colors, each represented by a letter, Red(R), Yellow(Y), Blue(B), Green(G), Purple(P) and Orange(O), You need to type each letter to try and break the code, Like so: RGBP!'
    p 'Black and white pegs, Black determine if the color is right and the position is too, white determine only that the colors are right but not the position, having 2 blacks and 2 whites means you have 2 right colored and right position and 2 right colored but not the right position.'
  end

  def play
    turn = 0
    create_code
    intro
    while turn != @turns
      turn += 1
      play_turn(turn)
    end
  end

  def player_guess(guess)
    guess.upcase.split('')
  end

  def play_turn(turn)
    p "whats your answer for this turn? turn:#{turn}"
    guess = gets.chomp
    array = player_guess(guess)
    @@guesses["turn#{turn}"] = array, [check_pegs(array)]
    show_board
    gameover(turn, check_pegs(array))
  end

  # Code checks for the pegs/'keys', If the item and index are the same
  # add + 1 to the black key value in the hash, if the item is in but no the same
  # index add +1 to white value return the hash,

  def show_board
    @@guesses.each do |names, values|
      p names, values
    end
  end

  def check_pegs(guess)
    black_white = { black: 0, white: 0 }
    @@code.each_with_index do |item, i|
      guess.each_with_index do |element, index|
        black_white[:black] += 1 if item == element && i == index
      end
      black_white[:white] += 1 if guess.include?(item)
    end
    black_white[:white] -= black_white[:black]
    black_white
  end

  def gameover(turn, bl_wh)
    if bl_wh[:black] == 4
      p "YOU WON!!! the code was #{@@code}!"
      sleep(5)
      exit
    end
    p "You lost sadly, The code was #{@@code}, Better luck next time!" unless turn < 12
  end
end

new_game = Game.new(12, 6)
new_game.play
