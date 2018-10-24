class Deck
  attr_accessor :new_cards
  def initialize
    deck = ["2C", "2D", "2H", "2S", "3C", "3D", "3H", "3S", "4C", "4D", "4H", "4S", "5C", "5D", "5H", "5S", "6C", "6D", "6H", "6S", "7C", "7D", "7H", "7S", "8C", "8D", "8H", "8S", "9C", "9D", "9H", "9S", "TC", "TD", "TH", "TS", "JC", "JD", "JH", "JS", "QC", "QD", "QH", "QS", "KC", "KD", "KH", "KS", "AC", "AD", "AH", "AS"]
      deck.shuffle!
      @new_cards = deck.pop(5).join(" ")
      p @new_cards
  end

end

class Hand

    attr_accessor :new_cards
    def initialize(cards)

      #uncomment  1st @cards and comment out the 2 @cards to play the game / Keep commented for testing

      # @cards = Deck.new.new_cards.gsub(/\s+/, "").scan(/.{2}/).map{|ch| Card.new(ch[0],suit(ch[1]))}
      @cards = cards.gsub(/\s+/, "").scan(/.{2}/).map{|ch| Card.new(ch[0],suit(ch[1]))}
    end
  
    def suits  
      [:clubs,:diamonds,:hearts,:spades]
    end

    def card
      @cards
    end

    def ranks
      [:high_card, :pair, :two_pairs, :three_of_a_kind, :straight, :flush, :full_house, :four_of_a_kind, :straight_flush]
    end
  
    def rank
      return :straight_flush if straight? && flush?
      return :flush          if flush?
      return :straight       if straight?
  
      card_idx = card_counts.sort.reverse
      return { [4,1] => :four_of_a_kind, [3,2] => :full_house, [3,1] => :three_of_a_kind, [2,2] => :two_pairs,[2,1] => :one_pair, [1,1] => :high_card}[card_idx[0..1]]
    end
  
    def <=>(other)
      keys <=> other.keys
    end
  
    def keys
      [ranking,card_counts]
    end
  
    def ranking
      ranks.index(rank)
    end

    def card_counts
      "23456789TJQKA".chars.collect {|char| card_count(char)}
    end
  
    def card_count(pips)
      @cards.count{|card| card.pips == pips}
      
    end
  
    def card_flags
      card_counts.map{|n| n > 0 ? 'T' : 'F'}.join
      # p card_counts
    end
  

    #if card_flags include the string of 'TTTTT' it returns straight, comes from the function above that replaces n with 'T' if n is greataer than zero
    def straight?
      card_flags.include? 'TTTTT'
      # p card_flags
    end
  

    # if suit_counts includes 5 n's it returns flush
    def flush?
      suit_counts.any? {|n| n == 5}
      # p suit_counts
    end
  
    def suit_counts
      suits.collect {|suit| suit_count(suit)}
    end

    def suit_count(suit)
      @cards.count {|card| card.suit == suit}
    end
  
    def suit(ch)
      return suits["CDHS".index(ch)]
    end
  
  end

  class Card
  
    def initialize(pips,suit)
      @pips,@suit = pips,suit
    end
  
    def ==(other)
      pips == other.pips && suit == other.suit
    end
  
    def pips
      @pips
    end
  
    def suit
      @suit
    end
  end

  


# UNCOMMENT TO PLAY THE GAME _ Keep Commented for testing

  # puts "Black"
  # black = Hand.new 
 
  # puts "White" 
  # white = Hand.new 
  
 
  # if (white <=> black) == 1
  #   puts "\n\nWhite Wins. - with #{white.rank}:"
  # elsif (white <=> black) == 0
  #   puts "Tie"
  # else 
  #   puts "Black Wins. - with #{black.rank}:"
  # end
