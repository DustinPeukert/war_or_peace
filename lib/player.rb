class Player
    attr_reader :name,
                :deck

    def initialize(name, deck)
        @name = name
        @deck = deck
    end

    def has_lost?
        @deck.cards.length == 0
    end

    def cards_amount
        @deck.cards.length # this is not a violation of the law of demeter
    end # because cards is an attribute of deck

    def rank_of_card_at(index) # this method allows us to access the rank using just the player class, rather than chaining methods
        @deck.rank_of_card_at(index) # avoids a violation of the law of Demeter
    end # this is called a wrapper method

    def remove_card
        @deck.remove_card
    end

    def add_card(card)
        @deck.add_card(card)
    end
end