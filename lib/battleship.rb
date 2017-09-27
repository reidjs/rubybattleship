#!/usr/bin/env ruby
require_relative 'board'
require_relative 'player'
class BattleshipGame
  attr_accessor :player1, :player2
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
  end
  def place_ships
    @player1.send(:place_ships)
    @player2.send(:place_ships)
  end
  def take_turns(num)
    p "It is now player #{num}\'s turn. Press ENTER to continue"
    input = gets
    if num == 1
      player = @player1
      other_player = @player2
      num = 2
    else
      player = @player2
      other_player = @player1
      num = 1
    end
    player.send(:attack_prompt,other_player.board)
    if other_player.lost?
      p "#{player} wins"
      return false
    end
    take_turns(num)
  end
end
def play_game
  p "Enter number of (human) players [1 or 2]: "
  input = gets.downcase.chomp
  if input == "1"
    p1 = Human.new
    p2 = Computer.new
  elsif input == "2"
    p1 = Human.new
    p2 = Human.new
  else
    return play_game
  end
  game = BattleshipGame.new(p1, p2)
  game.place_ships
  game.take_turns(1)
end
play_game
# p2 = Computer.new
