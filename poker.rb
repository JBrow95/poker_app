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
      '10' => 10,
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
  def initialize
    dealer = Deck.new.cards
    black = []
    white = []

    counter = 0
    dealer.keys.shuffle.each do |k|
      if counter.even? == true
        black << k
      else
        white << k
      end

      if counter == 9
        break
      end
      counter += 1
    end

    p black
    p white
  end
end

c = Hand.new

