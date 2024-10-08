require 'rspec'
require './lib/card'
require './lib/deck'

describe Deck do
    describe '#initialize' do
        it 'is a deck' do
            card1 = Card.new(:diamond, 'Queen', 12)
            card2 = Card.new(:spade, '3', 3)
            card3 = Card.new(:heart, 'Ace', 14)
            cards = [card1, card2, card3]
            deck = Deck.new(cards)

            expect(deck).to be_a(Deck)
        end

        it 'can return contained cards' do
            card1 = Card.new(:diamond, 'Queen', 12)
            card2 = Card.new(:spade, '3', 3)
            card3 = Card.new(:heart, 'Ace', 14)
            cards = [card1, card2, card3]
            deck = Deck.new(cards)

            expect(deck.cards).to eq([card1, card2, card3])
        end
    end

    describe '#rank_of_card_at' do
        it 'returns rank of card at specific array index' do
            card1 = Card.new(:diamond, 'Queen', 12)
            card2 = Card.new(:spade, '3', 3)
            card3 = Card.new(:heart, 'Ace', 14)
            cards = [card1, card2, card3]
            deck = Deck.new(cards)

            expect(deck.rank_of_card_at(0)).to eq(12)
            expect(deck.rank_of_card_at(2)).to eq(2)
        end
    end

    describe '#high_ranking_cards' do
        it 'returns an array of cards considered high-ranking' do
            card1 = Card.new(:diamond, 'Queen', 12)
            card2 = Card.new(:spade, '3', 3)
            card3 = Card.new(:heart, 'Ace', 14)
            cards = [card1, card2, card3]
            deck = Deck.new(cards)

            expect(deck.high_ranking_cards).to eq([card1, card3])
        end
    end

    describe '#percent_high_ranking' do
        it 'returns a percentage value of high-ranking cards to total cards' do
            card1 = Card.new(:diamond, 'Queen', 12)
            card2 = Card.new(:spade, '3', 3)
            card3 = Card.new(:heart, 'Ace', 14)
            cards = [card1, card2, card3]
            deck = Deck.new(cards)

            expect(deck.percent_high_ranking).to eq(66.67)
        end
    end

    describe '#remove_card' do
        it 'will remove the first card in the deck' do
            card1 = Card.new(:diamond, 'Queen', 12)
            card2 = Card.new(:spade, '3', 3)
            card3 = Card.new(:heart, 'Ace', 14)
            cards = [card1, card2, card3]
            deck = Deck.new(cards)

            deck.remove_card

            expect(deck.cards).to eq([card2, card3])
            expect(deck.high_ranking_cards).to eq([card3])
            expect(deck.percent_high_ranking).to eq(50)
        end
    end
end