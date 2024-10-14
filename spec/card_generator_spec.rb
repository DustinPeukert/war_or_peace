require 'rspec'
require './lib/card_generator'
require './lib/deck'
require './lib/card'

describe CardGenerator do
  describe '#initialize' do
    it 'is a CardGenerator' do
      card_generator = CardGenerator.new

      expect(card_generator).to be_a(CardGenerator)
    end

    it 'has an empty deck by default' do
      card_generator = CardGenerator.new

      expect(card_generator.deck).to eq([])
    end
  end
  
  describe '#create_cards' do
    it 'creates cards from a prebuilt text file' do
      card_generator = CardGenerator.new
      
      expect(card_generator.deck).to eq([])

      card_generator.create_cards('./spec/cards_spec.txt')

      expect(card_generator.deck.count).to eq(4) # we have 4 cards listed in our testing txt file
    end
  end
end