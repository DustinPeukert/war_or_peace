require 'rspec'
require './lib/card'
require './lib/deck'
require './lib/player'

describe Player do
    before(:each) do
        @card1 = Card.new(:diamond, 'Queen', 12)
        @card2 = Card.new(:spade, '3', 3)
        @card3 = Card.new(:heart, 'Ace', 14)
        @deck = Deck.new([@card1, @card2, @card3])
        @player = Player.new('Clarisa', @deck)
    end

    describe '#initialize' do
        it 'is a player' do
            expect(@player).to be_a(Player)
        end

        it 'has a name' do
            expect(@player.name).to eq('Clarisa')
        end

        it 'has a deck' do
            expect(@player.deck).to eq(@deck)
        end
    end

    describe '#has_lost?' do
        it 'has lost when it has no cards' do
            expect(@player.has_lost?).to be false

            @player.deck.remove_card
            expect(@player.has_lost?).to be false

            @player.deck.remove_card
            expect(@player.has_lost?).to be false

            @player.deck.remove_card
            expect(@player.has_lost?).to be true

            expect(@player.deck.remove_card).to eq([])
        end
    end
end