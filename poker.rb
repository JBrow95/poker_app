class Deck
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
    p values2
  end

  def cards
    p @cards
  end
end

c = Deck.new
