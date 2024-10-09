class Turn
  attr_reader :player1,
              :player2,
              :spoils_of_war
    
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @spoils_of_war = []
  end

  def type
    if @player1.deck.cards[0].rank != @player2.deck.cards[0].rank
      return :basic
    elsif @player1.deck.cards[0].rank == @player2.deck.cards[0].rank &&
          @player1.deck.cards[2].rank == @player2.deck.cards[2].rank
      return :mutually_assured_destruction
    elsif @player1.deck.cards[0].rank == @player2.deck.cards[0].rank
      return :war
    end
  end
end