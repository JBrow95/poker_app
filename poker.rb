class Deck
  attr_reader :cards

  def initialize
    values = {"2" => 2, "3" => 3, '4' => 4, '5' => 5, '6' => 6, '7' => 7, '8' => 8, '9' => 9, 'T' => 10, 'J' => 11, 'Q' => 12, 'K' => 13, 'A' => 14 }

    suits = ['C', 'H', 'D', 'S']
    values2 = {}
    
    values.each do |k, v|
      suits.each do |s|
        new_key = k + s
        values2[new_key] = v
      end
    end

    @cards = values2
    deal()
  end

  def deal()
    @black = []
    @white = []
    counter = 0

    @cards.keys.shuffle.each do |k|
      counter.even? ? @black << k : @white << k
      counter == 9 ? break : counter += 1
    end

    @black
    @white
  end  

  attr_accessor :black
  attr_accessor :white
end

class Hand
  attr_accessor :hand

  def initialize(hand, cards)
    @hand = hand
    @dealer = cards
    win
  end

  def ranks
    { :high_card => 1, :pair => 2, :two_pairs => 3, :three_of_a_kind => 4, :straight => 5, :flush => 6, :full_house => 7, :four_of_a_kind => 8, :straight_flush => 9 }
  end

  def rank
      return :straight_flush if straight == true && flush == true
      return :four_of_a_kind if four == true
      return :full_house if full == true
      return :flush if flush == true
      return :straight if straight == true
      return :three_of_a_kind if three == true
      return :two_pairs if two_pairs == true
      return :pair if pairs == true
      return :high_card if pairs != true
  end

  def flush
    results_b = []
    values_b = []

    @hand.each { |i| results_b << i[1] }

    return true if results_b.uniq.length == 1
  end

  def straight
    results_b = []

    @hand.each { |i| results_b << @dealer[i] }

    sorted = results_b.sort.reverse
    counter = 1

    sorted.each { |v| counter += 1 if v - 1 == sorted[counter] }
    
    return true if counter == 5    
  end

  def four
    results_b = []

    @hand.each { |i| results_b << @dealer[i] }
    
    results_b = results_b.sort

    unless results_b.uniq.length != 2
      return true if results_b[0] == results_b[3] || results_b[4] == results_b[1]
    end     
  end

  def full 
    results_b = []

    @hand.each { |i| results_b << @dealer[i] }

    results_b = results_b.sort

    unless results_b.uniq.length != 2
      return true if results_b[0] != results_b[3] && results_b[4] != results_b[1] 
    end     
  end

  def three
    results_b = []

    @hand.each { |i| results_b << @dealer[i] }

    results_b = results_b.sort

    unless results_b.uniq.length != 3
      return true if results_b[0] == results_b[2] || results_b[2] == results_b[4] || results_b[1] == results_b[3]
    end     
  end

  def two_pairs
    results_b = []

    @hand.each { |i| results_b << @dealer[i] }

    results_b = results_b.sort

    unless results_b.uniq.length != 3
      return true if results_b[0] != results_b[2] && results_b[2] != results_b[4] && results_b[1] != results_b[3]
    end     
  end

  def pairs
    results_b = []

    @hand.each { |i| results_b << @dealer[i] }
    
    return true if results_b.uniq.length == 4
  end

  def win
    final = ranks[rank]
  end

  attr_reader :hand
end

class Start_game
  def initialize
    game = Deck.new
    black = game.black
    white = game.white
    deck = game.cards
    @b = Hand.new(black, deck)
    @w = Hand.new(white, deck)
    results()
  end

  def results()  
    print "Black's Hand: #{@b.hand.join(" ")}\n"
    print "White's Hand: #{@w.hand.join(" ")}\n"

    print "\nWhite Wins. - with #{@w.rank}:" if (@w.win <=> @b.win) == 1
    print "\nTie" if (@w.win <=> @b.win) == 0
    
    print "\nBlack Wins. - with #{@b.rank}:" if (@w.win <=> @b.win) == -1
  end
end
Start_game.new    