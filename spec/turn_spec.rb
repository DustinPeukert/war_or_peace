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

    describe '#type' do
        describe ':basic turn' do
            it 'returns :basic if both players first cards are different' do
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

                expect(turn.type).to eq(:basic)
            end
        end

        describe ':war turn' do
            it 'returns :war if both players first cards are equal' do
                card1 = Card.new(:heart, 'Jack', 11)
                card2 = Card.new(:heart, '10', 10)
                card3 = Card.new(:heart, '9', 9)
                card4 = Card.new(:diamond, 'Jack', 11)
                card5 = Card.new(:heart, '8', 8)
                card6 = Card.new(:diamond, 'Queen', 12)
                card7 = Card.new(:heart, '3', 3)
                card8 = Card.new(:diamond, '2', 2)

                deck1 = Deck.new([card1, card2, card5, card8])
                deck2 = Deck.new([card4, card3, card6, card7])

                player1 = Player.new("Megan", deck1)
                player2 = Player.new("Aurora", deck2)

                turn = Turn.new(player1, player2)

                expect(turn.type).to eq(:war)
            end
        end

        describe ':mutually_assured_destruction turn' do
            it 'returns :mutually_assured_destruction if both players 1st and 3rd cards match' do
                card1 = Card.new(:heart, 'Jack', 11)
                card2 = Card.new(:heart, '10', 10)
                card3 = Card.new(:heart, '9', 9)
                card4 = Card.new(:diamond, 'Jack', 11)
                card5 = Card.new(:heart, '8', 8)
                card6 = Card.new(:diamond, '8', 8)
                card7 = Card.new(:heart, '3', 3)
                card8 = Card.new(:diamond, '2', 2)

                deck1 = Deck.new([card1, card2, card5, card8])
                deck2 = Deck.new([card4, card3, card6, card7])
                
                player1 = Player.new("Megan", deck1)
                player2 = Player.new("Aurora", deck2)

                turn = Turn.new(player1, player2)

                expect(turn.type).to eq(:mutually_assured_destruction)
            end
        end
    end

    describe '#winner' do
        it 'returns player with highest first card if turn type is :basic' do
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
        end

        it 'returns player with highest 3rd card if turn type is :war' do
            card1 = Card.new(:heart, 'Jack', 11)
            card2 = Card.new(:heart, '10', 10)
            card3 = Card.new(:heart, '9', 9)
            card4 = Card.new(:diamond, 'Jack', 11)
            card5 = Card.new(:heart, '8', 8)
            card6 = Card.new(:diamond, 'Queen', 12)
            card7 = Card.new(:heart, '3', 3)
            card8 = Card.new(:diamond, '2', 2)

            deck1 = Deck.new([card1, card2, card5, card8])
            deck2 = Deck.new([card4, card3, card6, card7])

            player1 = Player.new("Megan", deck1)
            player2 = Player.new("Aurora", deck2)

            turn = Turn.new(player1, player2)

            winner = turn.winner

            expect(winner).to eq(player2)
        end

        it 'returns none if both players 1st and 3rd cards are equal' do
            card1 = Card.new(:heart, 'Jack', 11)
            card2 = Card.new(:heart, '10', 10)
            card3 = Card.new(:heart, '9', 9)
            card4 = Card.new(:diamond, 'Jack', 11)
            card5 = Card.new(:heart, '8', 8)
            card6 = Card.new(:diamond, '8', 8)
            card7 = Card.new(:heart, '3', 3)
            card8 = Card.new(:diamond, '2', 2)

            deck1 = Deck.new([card1, card2, card5, card8])
            deck2 = Deck.new([card4, card3, card6, card7])
                
            player1 = Player.new("Megan", deck1)
            player2 = Player.new("Aurora", deck2)

            turn = Turn.new(player1, player2)

            winner = turn.winner

            expect(winner).to eq("No Winner")
        end
    end
end