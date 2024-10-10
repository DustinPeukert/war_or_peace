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

  def winner
    if @player1.deck.cards[0].rank > @player2.deck.cards[0].rank
      return @player1
    elsif @player1.deck.cards[0].rank < @player2.deck.cards[0].rank
      return @player2
    elsif @player1.deck.cards[0].rank == @player2.deck.cards[0].rank
      if @player1.deck.cards[2].rank > @player2.deck.cards[2].rank
        return @player1
      elsif @player1.deck.cards[2].rank < @player2.deck.cards[2].rank
        return @player2 
      else
        return "No Winner"
      end
    end
  end

  def pile_cards
    if type == :basic
      @spoils_of_war << @player1.deck.cards.shift
      @spoils_of_war << @player2.deck.cards.shift
    elsif type == :war
      @spoils_of_war << @player1.deck.cards.shift(3)
      @spoils_of_war << @player2.deck.cards.shift(3)
      @spoils_of_war.flatten! # ! changes initial array rather than returning a new one
    elsif type == :mutually_assured_destruction
      @player1.deck.cards.shift(3)
      @player2.deck.cards.shift(3)
    end
  end

  def award_spoils(winner)
    winner.deck.cards.concat(@spoils_of_war)
    @spoils_of_war.clear
  end
end