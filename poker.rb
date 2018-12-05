class Deck
  attr_reader :cards

  def initialize
    values = {
      "2" => 2,
      "3" => 3,
      '4' => 4,
      '5' => 5,
      '6' => 6,
      '7' => 7,
      '8' => 8,
      '9' => 9,
      'T' => 10,
      'J' => 11,
      'Q' => 12,
      'K' => 13,
      'A' => 14
    }

    suits = ['C', 'H', 'D', 'S']
    values2 = {}
    values.each do |k, v|
      suits.each do |s|
        new_key = k + s
        values2[new_key] = v
      end
    end

    @cards = values2
  end
end

class Hand
  attr_accessor :black, :white
  def initialize(hand)
    @dealer = Deck.new.cards
    @hand = hand
    win
    counter = 0
    # @dealer.keys.shuffle.each do |k|
    #   if counter.even? == true
    #     @black << k
    #   else
    #     @white << k
    #   end

    #   if counter == 9
    #     break
    #   end
    #   counter += 1
    # end
  end

  def ranks
    {
      :high_card => 1, 
      :pair => 2, 
      :two_pairs => 3, 
      :three_of_a_kind => 4, 
      :straight => 5, 
      :flush => 6, 
      :full_house => 7, 
      :four_of_a_kind => 8, 
      :straight_flush => 9
    }
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
    results_w = []
    values_b = []
    @hand.each do |i|
      results_b << i[1]
      # values_b << @dealer[i]
    end

    if results_b.uniq.length == 1
      return true
    end
  end

  def straight
    results_b = []

    @hand.each do |i|
      results_b << @dealer[i]
    end
    sorted = results_b.sort.reverse
    counter = 1
    sorted.each do |v|
      if v - 1 == sorted[counter]
        counter += 1
      end
    end

    if counter == 5
      return true
    end    
  end

  def four
    results_b = []

    @hand.each do |i|
      results_b << @dealer[i]
    end

    results_b = results_b.sort

    unless results_b.uniq.length != 2
      if results_b[0] == results_b[3] || results_b[4] == results_b[1]
        return true
      end
    end     
  end

  def full 
    results_b = []

    @hand.each do |i|
      results_b << @dealer[i]
    end

    results_b = results_b.sort

    unless results_b.uniq.length != 2
      if results_b[0] != results_b[3] && results_b[4] != results_b[1] 
        return true
      end
    end     
  end

  def three
    results_b = []

    @hand.each do |i|
      results_b << @dealer[i]
    end

    results_b = results_b.sort

    unless results_b.uniq.length != 3
      if results_b[0] == results_b[2] || results_b[2] == results_b[4] || results_b[1] == results_b[3]
        return true
      end
    end     
  end

  def two_pairs
    results_b = []

    @hand.each do |i|
      results_b << @dealer[i]
    end

    results_b = results_b.sort

    unless results_b.uniq.length != 3
      if results_b[0] != results_b[2] && results_b[2] != results_b[4] && results_b[1] != results_b[3]
        return true
      end
    end     
  end

  def pairs
    results_b = []

    @hand.each do |i|
      results_b << @dealer[i]
    end
    
    if results_b.uniq.length == 4
      return true
    end
  end

  def win
    final = ranks[rank]
  
  end

  attr_reader :hand
end



b = ["3S", "3H", "6H", "3C", "QD"]
w = ["9H", "9S", "7D", "3D", "QS"]

black = Hand.new(b)
white = Hand.new(w)
print "Black's Hand: #{black.hand.join(" ")}\n"
print "White's Hand: #{white.hand.join(" ")}\n"

if (white.win <=> black.win) == 1
  print "\nWhite Wins. - with #{white.rank}:"
elsif (white.win <=> black.win) == 0
  print "\nTie"
elsif (white.win <=> black.win) == -1
  print "\nBlack Wins. - with #{black.rank}:"
end