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
end