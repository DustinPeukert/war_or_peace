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
    if @player1.rank_of_card_at(0) != @player2.rank_of_card_at(0)
      :basic
    elsif @player1.rank_of_card_at(0) == @player2.rank_of_card_at(0) &&
          @player1.rank_of_card_at(2) == @player2.rank_of_card_at(2)
      :mutually_assured_destruction
    elsif @player1.rank_of_card_at(0) == @player2.rank_of_card_at(0)
      :war
    end
  end

  def winner
    if @player1.rank_of_card_at(0) > @player2.rank_of_card_at(0)
      @player1
    elsif @player1.rank_of_card_at(0) < @player2.rank_of_card_at(0)
      @player2
    elsif @player1.rank_of_card_at(0) == @player2.rank_of_card_at(0)
      if @player1.rank_of_card_at(2) > @player2.rank_of_card_at(2)
        @player1
      elsif @player1.rank_of_card_at(2) < @player2.rank_of_card_at(2)
        @player2 
      else
        "No Winner"
      end
    end
  end

  def pile_cards
    if type == :basic
      @spoils_of_war << @player1.remove_card
      @spoils_of_war << @player2.remove_card
    elsif type == :war
      3.times do
        @spoils_of_war << @player1.remove_card
      end
      3.times do
        @spoils_of_war << @player2.remove_card
      end
    elsif type == :mutually_assured_destruction
      3.times do
        @player1.remove_card
        @player2.remove_card
      end
    end
  end

  def award_spoils(winner)
    if winner != "No Winner"
      @spoils_of_war.shuffle!
      @spoils_of_war.each do |card|
        winner.add_card(card)
      end
      @spoils_of_war.clear
    end
  end
end