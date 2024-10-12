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
end