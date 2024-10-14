class Player
    attr_reader :name,
                :deck

    def initialize(name, deck)
        @name = name
        @deck = deck
    end

    def has_lost?
        return true if @deck.cards.length == 0
        false
    end

    def cards_amount
        @deck.cards.length # this is a violation of the demeter law, refactor this later after reading more
    end

    def rank_of_card_at(index) # this method allows us to access the rank using just the player class, rather than chaining methods
        @deck.rank_of_card_at(index) # avoids a violation of the law of Demeter
    end

    def remove_card
        @deck.remove_card
    end
end