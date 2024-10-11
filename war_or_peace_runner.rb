require_relative 'lib/game'

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

game = Game.new # This creates our game object and sets up the decks and players through initialization

puts "Welcome to War! (or Peace). This game will be played with 52 cards."
puts "The players today are Megan and Aurora."
puts "Type 'Go' to start the game!"
puts "-------------------------------------------------------------------"

get_go # calls the method to get user input

game.start # the start method of our game class actually begins the game

if game.turn_number == 1000000 && (game.player1.has_lost? == game.player2.has_lost?)
  puts "---- DRAW ----"
elsif game.player1.has_lost?
  puts "*~*~*~* #{game.player2.name} has won the game! *~*~*~*"
elsif game.player2.has_lost?
  puts "*~*~*~* #{game.player1.name} has won the game! *~*~*~*"
end

puts "#{game.player1.name} won #{game.player1_wins} turns!"
puts "#{game.player2.name} won #{game.player2_wins} turns!"
puts "#{game.no_winners} turn(s) ended with no winners!"

if game.mad_count == 1
  puts "There was 1 mutually assured destruction this game!"
else
  puts "There were #{game.mad_count} mutually assured destructions this game!"
end

if game.war_count == 1
  puts "There was 1 war this game!"
else
  puts "There were #{game.war_count} wars this game!"
end

# ctrl + c to exit endless loops