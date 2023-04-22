require 'debug'
require_relative 'card'
require_relative 'player'
require_relative 'dealer'
require_relative 'cpu'
require_relative 'black_jack_2'

card = Card.new
player1 = Player.new('あなた')
dealer = Dealer.new
game = Game_Black_Jack.new(player1, dealer, card)
game.start_game