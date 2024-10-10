require './lib/card'
require './lib/deck'
require './lib/player'
require './lib/turn'

class Game
  attr_accessor :player1,
                :player2

  def initialize
    suits = [:heart, :diamond, :club, :spade]
    values = ['2', '3', '4', '5', '6', '7', '8', '9',
              '10', 'Jack', 'Queen', 'King', 'Ace']
    ranks = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]
    full_deck = []

    suits.each do |suit|
      values.each_with_index do |value, index| # .each_with_index works like a normal .each while also keeping track of the current array index
        full_deck << Card.new(suit, value, ranks[index]) # ranks[index] returns the value of ranks at a specific index and passes that value as an argument
      end
    end

    full_deck = full_deck.shuffle # .shuffle randomly rearranges elements of an array

    deck1 = Deck.new(full_deck[0..26])
    deck2 = Deck.new(full_deck[26..51])
    
    @player1 = Player.new('Megan', deck1)
    @player2 = Player.new('Aurora', deck2)
  end
end