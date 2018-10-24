class Deck
    attr_reader :cards, :values

    def initialize
        @cards = []
        @values = ['2','3','4','5','6','7','8','9','T','J','Q','K','A']
        @suits = ['C', 'D', 'H', 'S']
        @suits.each do |s|
            @values.each do |v|
                @cards << v + s
            end
        end
        @cards
    end
end

class Hand