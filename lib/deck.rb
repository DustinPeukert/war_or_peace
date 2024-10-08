class Deck
    attr_reader :cards

    def initialize(cards)
        @cards = cards
    end

    def rank_of_card_at(index)
        @cards[index].rank
    end

    def high_ranking_cards
        high_ranking_cards = []

        @cards.each do |card|
            if card.rank >= 11
                high_ranking_cards << card
            end
        end

        high_ranking_cards
    end

    def percent_high_ranking
        high_rank_count = 0.0
        total_cards = @cards.length.to_f

        @cards.each do |card|
            if card.rank >= 11
                high_rank_count += 1
            end
        end

        percent_high_ranking = (high_rank_count / total_cards) * 100
        percent_high_ranking.round(2)
    end

    def remove_card
        @cards.shift
    end

    def add_card(card)
        @cards.append(card)
    end
end