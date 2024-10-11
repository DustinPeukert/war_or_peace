require_relative 'card'
require_relative 'deck'
require_relative 'player'
require_relative 'turn'

class Game
  attr_reader :player1_wins,
              :player2_wins,
              :no_winners,
              :mad_count,
              :war_count,
              :turn_number,
              :player1,
              :player2

  def initialize
    @player1_wins = 0 #testing variables
    @player2_wins = 0
    @no_winners = 0
    @mad_count = 0
    @war_count = 0
    suits = [:heart, :diamond, :club, :spade] # setup arrays used to create decks
    values = ['2', '3', '4', '5', '6', '7', '8', '9',
              '10', 'Jack', 'Queen', 'King', 'Ace']
    ranks = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]
    full_deck = []
    
    suits.each do |suit| # iterates between each suit
      values.each_with_index do |value, index| # .each_with_index works like a normal .each while also keeping track of the current array index
        full_deck << Card.new(suit, value, ranks[index]) # ranks[index] returns the value of ranks at a specific index and passes that value as an argument
      end # .each_with_index allows us to iterate between the values and ranks arrays
    end   # this is a special case though, because our value and rank arrays are the exact same size
    
    full_deck = full_deck.shuffle # .shuffle randomly rearranges elements of an array
    
    deck1 = Deck.new(full_deck[0...26]) # Puts first 26 cards into deck1
    deck2 = Deck.new(full_deck[26..51]) # Puts last 26 cards into deck2
    
    @player1 = Player.new('Megan', deck1) # creates player 1
    @player2 = Player.new('Aurora', deck2) # creates player 2
  end

  def start
    1000000.times do |number| # makes sure the turn amount only goes to 1000000
      @turn_number = number + 1

      if @player1.has_lost? || @player2.has_lost? # Will break the loop if a player.has_lost? returns true
        break
      end

      # We want to add a contingency in case a player doesn't have enough cards to play for
      # a :war or :mutually_assured_destruction turn type
      # Instead of playing through a whole turn we will end the turn by giving the rest of
      # the cards from the player that doesnt have enough, to the other player

      if (@player1.cards_amount < 3 || @player2.cards_amount < 3) && 
        (@player1.deck.rank_of_card_at(0) == @player2.deck.rank_of_card_at(0))
        if @player2.cards_amount < 3
          @player1.deck.cards.concat(@player2.deck.cards)
          @player2.deck.cards.clear 
          break
        elsif @player1.cards_amount < 3
          @player2.deck.cards.concat(@player1.deck.cards)
          @player1.deck.cards.clear
          break
        end
      end

      turn = Turn.new(@player1, @player2) # creates a new turn object using the same player objects every .time iteration

      turn_winner = turn.winner # we need to store the winner and turn type attributes before we pile the cards
      turn_type = turn.type     # since these will change after we move cards
      turn.pile_cards
      cards_won = turn.spoils_of_war.count #determines how many cards are won based on the amount of cards in spoils of war

      if turn_type == :basic # determines correct terminal output based on turn type
        print "Turn #{@turn_number}: #{turn_winner.name} won #{cards_won} cards\n"
      elsif turn_type == :war
        print "Turn #{@turn_number}: WAR - #{turn_winner.name} won #{cards_won} cards\n"
      elsif turn_type == :mutually_assured_destruction
        puts "Turn #{@turn_number}: *mutually assured destruction* 6 cards removed from play"
      end

      if turn_winner != "No Winner" # contingency in the case that mutually assured destruction happens
        turn.award_spoils(turn_winner)
      end

      # keeps track of how many times "special" turn types happen
      if turn_type == :mutually_assured_destruction 
        @mad_count += 1
      elsif turn_type == :war
        @war_count += 1
      end

      # keeps track of how many times each player wins a turn throughout the game as well as how many times there was no turn winner
      if turn_winner == player1
        @player1_wins += 1
      elsif turn_winner == player2
        @player2_wins += 1
      elsif turn_winner == "No Winner"
        @no_winners += 1
      end
    end
  end
end