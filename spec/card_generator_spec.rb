require 'rspec'
require './lib/card_generator'
require './lib/deck'
require './lib/card'

describe CardGenerator do
  describe '#initialize' do
    it 'is a CardGenerator' do
      empty_deck = Deck.new([])
      card_generator = CardGenerator.new(empty_deck)

      expect(card_generator).to be_a(CardGenerator)
    end

    it 'can return a deck object as an attribute' do
      empty_deck = Deck.new([])
      card_generator = CardGenerator.new(empty_deck)

      expect(card_generator.deck).to be_a(Deck)
    end
  end
  
  describe '#create_cards' do
    it 'creates cards from a prebuilt text file' do
      empty_deck = Deck.new([])
      
      card_generator = CardGenerator.new(empty_deck)
      
      expect(card_generator.deck.cards).to eq([])

      card_generator.create_cards

      expect(card_generator.deck.cards.count).to eq(4) # we have 4 cards listed in our testing txt file
    end
  end
end