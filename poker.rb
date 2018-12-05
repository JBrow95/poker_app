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
  def initialize(black, white)
    @dealer = Deck.new.cards
    @black = black
    @white = white

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
    [
      :high_card, 
      :pair, 
      :two_pairs, 
      :three_of_a_kind, 
      :straight, 
      :flush, 
      :full_house, 
      :four_of_a_kind, 
      :straight_flush
    ]
  end

  def rank
    return :straight_flush if straight == true && flush == true
    return :four_of_a_kind if four == true
    return :full_house if full == true
    return :flush if flush == true
    return :straight if straight == true
    return :three_of_a_kind if three == true
  end

  def flush
    results_b = []
    results_w = []
    values_b = []
    @black.each do |i|
      results_b << i[1]
      # values_b << @dealer[i]
    end

    if results_b.uniq.length == 1
      return true
    end
  end

  def straight
    results_b = []

    @black.each do |i|
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

    @black.each do |i|
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

    @black.each do |i|
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

    @black.each do |i|
      results_b << @dealer[i]
    end

    results_b = results_b.sort

    unless results_b.uniq.length != 3
      if results_b[0] == results_b[2] || results_b[2] == results_b[4] || results_b[1] == results_b[3]
        return true
      end
    end     
  end
end
