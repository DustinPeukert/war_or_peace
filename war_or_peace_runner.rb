require_relative 'lib/turn'
require_relative 'lib/card'
require_relative 'lib/deck'
require_relative 'lib/player'

def get_go # our method to get user input
  input = ""

  while input != 'Go'
    initial_input = gets.chomp # .chomp removes the newline character automatically added during user input
    input = initial_input.capitalize # this makes sure that the user can write 'Go any way theyd like as long as it is spelled correctly'
    
    if input != 'Go' # this lets the user know they did not enter 'Go'
      puts "Please type 'Go' to start the game!"
    end
  end
end

puts "Welcome to War! (or Peace). This game will be played with 52 cards."
puts "The players today are Megan and Aurora."
puts "Type 'Go' to start the game!"
puts "-------------------------------------------------------------------"

get_go # calls the method to get user input


suits = [:heart, :diamond, :club, :spade] # setup code used to create decks
values = ['2', '3', '4', '5', '6', '7', '8', '9',
          '10', 'Jack', 'Queen', 'King', 'Ace']
ranks = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]
full_deck = []

suits.each do |suit| # iterates between each suit
  values.each_with_index do |value, index| # .each_with_index works like a normal .each while also keeping track of the current array index
    full_deck << Card.new(suit, value, ranks[index]) # ranks[index] returns the value of ranks at a specific index and passes that value as an argument
  end # .each_with_index allows us to iterate between the values and ranks arrays
end   # this is a special case though, because our value and rank arrays are the exact same size

10.times do
  full_deck = full_deck.shuffle # .shuffle randomly rearranges elements of an array
end

deck1 = Deck.new(full_deck[0...26]) # Puts first 26 cards into deck1
deck2 = Deck.new(full_deck[26..51]) # Puts last 26 cards into deck2

player1 = Player.new('Megan', deck1) # creates player 1
player2 = Player.new('Aurora', deck2) # creates player 2


# We want to add a contingency in case a player doesn't have enough cards to play for
# a :war or :mutually_assured_destruction turn type
# Instead of playing through a whole turn we will end the turn by giving the rest of
# the cards from the player that doesnt have enough, to the other player

@player1_wins = 0
@player2_wins = 0
@no_winners = 0
@mad_count = 0
@war_count = 0

1000000.times do |number| # makes sure the turn amount only goes to 1000000
  @turn_number = number + 1

  if player1.has_lost? || player2.has_lost? # Will break the loop if a player.has_lost? returns true
    break
  end

  if (player1.cards_amount < 3 || player2.cards_amount < 3) && 
     (player1.deck.rank_of_card_at(0) == player2.deck.rank_of_card_at(0))
    if player2.cards_amount < 3
      player1.deck.cards.concat(player2.deck.cards)
      player2.deck.cards.clear 
      break
    elsif player1.cards_amount < 3
      player2.deck.cards.concat(player1.deck.cards)
      player1.deck.cards.clear
      break
    end
  end

  turn = Turn.new(player1, player2)

  turn_winner = turn.winner 
  turn_type = turn.type
  turn.pile_cards
  cards_won = turn.spoils_of_war.count 

  if turn_type == :basic
    print "Turn #{@turn_number}: #{turn_winner.name} won #{cards_won} cards\n"
  elsif turn_type == :war
    print "Turn #{@turn_number}: WAR - #{turn_winner.name} won #{cards_won} cards\n"
  elsif turn_type == :mutually_assured_destruction
    puts "Turn #{@turn_number}: *mutually assured destruction* 6 cards removed from play"
  end

  if turn_winner != "No Winner"
    turn.award_spoils(turn_winner) # issure might be here
  end

  if turn_type == :mutually_assured_destruction
    @mad_count += 1
  elsif turn_type == :war
    @war_count += 1
  end

  if turn_winner == player1
    @player1_wins += 1
  elsif turn_winner == player2
    @player2_wins += 1
  elsif turn_winner == "No Winner"
    @no_winners += 1
  end
end

if @turn_number == 1000000 && (player1.has_lost? == player2.has_lost?)
  puts "---- DRAW ----"
elsif player1.has_lost?
  puts "*~*~*~* #{player2.name} has won the game! *~*~*~*"
elsif player2.has_lost?
  puts "*~*~*~* #{player1.name} has won the game! *~*~*~*"
end

puts @player1_wins
puts @player2_wins
puts @no_winners
puts @mad_count
puts @war_count

# ctrl + c to exit endless loops