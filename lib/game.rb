require_relative 'card'
require_relative 'deck'
require_relative 'player'
require_relative 'turn'
require_relative 'card_generator'

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
    @player1_wins = 0 # testing variables
    @player2_wins = 0
    @no_winners = 0
    @mad_count = 0
    @war_count = 0

    @turn_number = 0 # used to track turn number
  end

  def setup
    card_generator = CardGenerator.new

    card_generator.create_cards("./data/cards.txt")

    full_deck = card_generator.deck
    full_deck.shuffle!

    deck1 = Deck.new(full_deck[0...26]) # Puts first 26 cards into deck1
    deck2 = Deck.new(full_deck[26..51]) # Puts last 26 cards into deck2
    
    @player1 = Player.new('Megan', deck1) # creates player 1
    @player2 = Player.new('Aurora', deck2) # creates player 2
  end

  def introduction
    puts "Welcome to War! (or Peace). This game will be played with 52 cards."
    puts "The players today are Megan and Aurora."
    puts "Type 'Go' to start the game!"
    puts "-------------------------------------------------------------------"
  end

  def get_go_from_user # our method to get user input
    input = ""
  
    while input != 'Go'
      initial_input = gets.chomp # .chomp removes the newline character automatically added during user input
      input = initial_input.capitalize # this makes sure that the user can write 'Go any way theyd like as long as it is spelled correctly'
      
      if input != 'Go' # this lets the user know they did not enter 'Go'
        puts "Please type 'Go' to start the game!"
      end
    end
  end

  def print_turn_info
    @turn_winner = @turn.winner # we need to store the winner and turn type attributes before we pile the cards
    @turn_type = @turn.type     # since these will change after we move cards
    @turn.pile_cards
    cards_won = @turn.spoils_of_war.count #determines how many cards are won based on the amount of cards in spoils of war

    if @turn_type == :basic # determines correct terminal output based on turn type
      puts "Turn #{@turn_number}: #{@turn_winner.name} won #{cards_won} cards"
    elsif @turn_type == :war
      puts "Turn #{@turn_number}: WAR - #{@turn_winner.name} won 6 cards"
    elsif @turn_type == :mutually_assured_destruction
      puts "Turn #{@turn_number}: *mutually assured destruction* 6 cards removed from play"
    end
  end

  def determine_winner
    if @turn_number == 1000000 && (@player1.has_lost? == @player2.has_lost?)
      puts "---- DRAW ----"
    elsif @player1.has_lost?
      puts "*~*~*~* #{@player2.name} has won the game! *~*~*~*"
    elsif @player2.has_lost?
      puts "*~*~*~* #{@player1.name} has won the game! *~*~*~*"
    end
  end

  def determine_statistics
    # keeps track of how many times "special" turn types happen
    if @turn_type == :mutually_assured_destruction 
      @mad_count += 1
    elsif @turn_type == :war
      @war_count += 1
    end

    # keeps track of how many times each player wins a turn throughout the game as well as how many times there was no turn winner
    if @turn_winner == @player1
      @player1_wins += 1
    elsif @turn_winner == @player2
      @player2_wins += 1
    elsif @turn_winner == "No Winner"
      @no_winners += 1
    end
  end

  def print_statistics
    puts "#{@player1.name} won #{@player1_wins} turns!"
    puts "#{@player2.name} won #{@player2_wins} turns!"
    puts "#{@no_winners} turn(s) ended with no winners!"

    if @mad_count == 1
      puts "There was 1 mutually assured destruction this game!"
    else
      puts "There were #{@mad_count} mutually assured destructions this game!"
    end

    if @war_count == 1
      puts "There was 1 war this game!"
    else
      puts "There were #{@war_count} wars this game!"
    end
  end

  def start
    setup
    introduction
    get_go_from_user

    while !@player1.has_lost? && !@player2.has_lost? && @turn_number != 1000000 do
      @turn_number += 1
      @turn = Turn.new(@player1, @player2)

      # We want to add a contingency in case a player doesn't have enough cards to play for
      # a :war or :mutually_assured_destruction turn type
      # Instead of playing through a whole turn we will end the turn by giving the rest of
      # the cards from the player that doesnt have enough, to the other player

      if (@turn.player1.cards_amount < 3 || @turn.player2.cards_amount < 3) &&
         (@turn.player1.rank_of_card_at(0) == @turn.player2.rank_of_card_at(0))
        if @turn.player2.cards_amount < 3
          @turn.player1.cards.concat(@turn.player2.cards)
          @turn.player2.cards.clear 
          break
        elsif @turn.player1.cards_amount < 3
          @turn.player2.cards.concat(@turn.player1.cards)
          @turn.player1.cards.clear
          break
        end
      end

      print_turn_info

      @turn.award_spoils(@turn_winner)

      determine_statistics
    end

    determine_winner
    print_statistics
  end
end