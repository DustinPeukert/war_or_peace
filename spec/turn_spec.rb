require 'rspec'
require './lib/card'
require './lib/deck'
require './lib/player'
require './lib/turn'

describe Turn do
    describe '#initialize' do
        before(:each) do
            @card1 = Card.new(:heart, 'Jack', 11)
            @card2 = Card.new(:heart, '10', 10)
            @card3 = Card.new(:heart, '9', 9)
            @card4 = Card.new(:diamond, 'Jack', 11)
            @card5 = Card.new(:heart, '8', 8)
            @card6 = Card.new(:diamond, 'Queen', 12)
            @card7 = Card.new(:heart, '3', 3)
            @card8 = Card.new(:diamond, '2', 2)

            @deck1 = Deck.new([@card1, @card2, @card5, @card8])
            @deck2 = Deck.new([@card3, @card4, @card6, @card7])

            @player1 = Player.new("Megan", @deck1)
            @player2 = Player.new("Aurora", @deck2)

            @turn = Turn.new(@player1, @player2)
        end

        it 'is a turn' do
            expect(@turn).to be_a(Turn)
        end

        it 'has 2 players' do
            expect(@turn.player1).to eq(@player1)
            expect(@turn.player2).to eq(@player2)
        end

        it 'has no spoils of war by default' do
            expect(@turn.spoils_of_war).to eq([])
        end
    end

    describe 'Turn when type :basic' do
        before(:each) do
            @card1 = Card.new(:heart, 'Jack', 11)
            @card2 = Card.new(:heart, '10', 10)
            @card3 = Card.new(:heart, '9', 9)
            @card4 = Card.new(:diamond, 'Jack', 11)
            @card5 = Card.new(:heart, '8', 8)
            @card6 = Card.new(:diamond, 'Queen', 12)
            @card7 = Card.new(:heart, '3', 3)
            @card8 = Card.new(:diamond, '2', 2)

            @deck1 = Deck.new([@card1, @card2, @card5, @card8])
            @deck2 = Deck.new([@card3, @card4, @card6, @card7])

            @player1 = Player.new("Megan", @deck1)
            @player2 = Player.new("Aurora", @deck2)

            @turn = Turn.new(@player1, @player2)
        end

        describe '#type' do
            it 'returns :basic if both players first cards are different ranks' do
                expect(@card1.rank != @card3.rank).to be true
                expect(@turn.type).to eq(:basic) 
            end
        end

        describe '#winner' do
            it 'returns player with highest first card when turn type :basic' do
                winner = @turn.winner

                expect(@card1.rank > @card3.rank).to be true
                expect(winner).to eq(@player1)
            end
        end

        describe '#pile_cards' do
            it 'sends both players top cards to the spoils pile if turn type = :basic' do
                @turn.pile_cards

                expect(@turn.spoils_of_war).to eq([@card1, @card3])
                expect(@player1.deck.cards).to eq([@card2, @card5, @card8])
                expect(@player2.deck.cards).to eq([@card4, @card6, @card7])
            end
        end
    end

    describe 'Turn when type :war' do
        before(:each) do
            @card1 = Card.new(:heart, 'Jack', 11)
            @card2 = Card.new(:heart, '10', 10)
            @card3 = Card.new(:heart, '9', 9)
            @card4 = Card.new(:diamond, 'Jack', 11)
            @card5 = Card.new(:heart, '8', 8)
            @card6 = Card.new(:diamond, 'Queen', 12)
            @card7 = Card.new(:heart, '3', 3)
            @card8 = Card.new(:diamond, '2', 2)

            @deck1 = Deck.new([@card1, @card2, @card5, @card8])
            @deck2 = Deck.new([@card4, @card3, @card6, @card7])

            @player1 = Player.new("Megan", @deck1)
            @player2 = Player.new("Aurora", @deck2)

            @turn = Turn.new(@player1, @player2)
        end

        describe '#type' do
            it 'returns :war if both players first cards are equal rank' do
                expect(@card1.rank == @card4.rank).to be true
                expect(@turn.type).to eq(:war) 
            end
        end

        describe '#winner' do
            it 'returns player with highest 3rd card if turn type is :war' do
                winner = @turn.winner

                expect(@card1.rank == @card4.rank).to be true
                expect(winner).to eq(@player2)
            end
        end

        describe '#pile_cards' do
            it 'sends both players top 3 cards to the spoils pile if turn type = :war' do
                @turn.pile_cards

                expect(@turn.spoils_of_war).to eq([@card1, @card2, @card5, @card4, @card3, @card6])
                expect(@player1.deck.cards).to eq([@card8])
                expect(@player2.deck.cards).to eq([@card7])
            end
        end
    end

    describe 'Turn when type :mutually_assured_destruction' do
        before(:each) do
            @card1 = Card.new(:heart, 'Jack', 11)
            @card2 = Card.new(:heart, '10', 10)
            @card3 = Card.new(:heart, '9', 9)
            @card4 = Card.new(:diamond, 'Jack', 11)
            @card5 = Card.new(:heart, '8', 8)
            @card6 = Card.new(:diamond, '8', 8)
            @card7 = Card.new(:heart, '3', 3)
            @card8 = Card.new(:diamond, '2', 2)

            @deck1 = Deck.new([@card1, @card2, @card5, @card8])
            @deck2 = Deck.new([@card4, @card3, @card6, @card7])
            
            @player1 = Player.new("Megan", @deck1)
            @player2 = Player.new("Aurora", @deck2)

            @turn = Turn.new(@player1, @player2)
        end

        describe '#type' do
            it 'returns :mutually_assured_destruction if both players 1st and 3rd cards are equal rank' do
                expect(@card1.rank == @card4.rank && @card5.rank == @card6.rank).to be true
                expect(@turn.type).to eq(:mutually_assured_destruction)
            end
        end

        describe '#winner' do
            it 'returns none when turn type :mutually_assured_destruction' do
                winner = @turn.winner

                expect(@card1.rank == @card4.rank && @card5.rank == @card6.rank).to be true
                expect(winner).to eq("No Winner")
            end
        end

        describe '#pile_cards' do
            it 'removes both players top 3 cards from game if turn type = :mutually_assured_destruction' do
                @turn.pile_cards

                expect(@turn.spoils_of_war).to eq([])
                expect(@player1.deck.cards).to eq([@card8])
                expect(@player2.deck.cards).to eq([@card7])
            end
        end
    end

    describe '#award_spoils' do
        it 'gives the winner of the turn all cards in @spoils_of_war' do
            card1 = Card.new(:heart, 'Jack', 11)
            card2 = Card.new(:heart, '10', 10)
            card3 = Card.new(:heart, '9', 9)
            card4 = Card.new(:diamond, 'Jack', 11)
            card5 = Card.new(:heart, '8', 8)
            card6 = Card.new(:diamond, 'Queen', 12)
            card7 = Card.new(:heart, '3', 3)
            card8 = Card.new(:diamond, '2', 2)

            deck1 = Deck.new([card1, card2, card5, card8])
            deck2 = Deck.new([card3, card4, card6, card7])

            player1 = Player.new("Megan", deck1)
            player2 = Player.new("Aurora", deck2)

            turn = Turn.new(player1, player2)

            winner = turn.winner
            expect(winner).to eq(player1)

            turn.pile_cards
            expect(turn.spoils_of_war).to eq([card1, card3])
            expect(player1.deck.cards).to eq([card2, card5, card8])
            expect(player2.deck.cards).to eq([card4, card6, card7])

            turn.award_spoils(winner)
            expect(turn.spoils_of_war).to eq([])
            expect(player1.deck.cards).to eq([card2, card5, card8, card1, card3])
            expect(player2.deck.cards).to eq([card4, card6, card7])
        end
    end
end