require_relative 'poker.rb'
require 'test/unit'

class TestUntitled < Test::Unit::TestCase

  def test_start
    hand = Hand.new("2H 4S 4C 2D 4H")
    assert_equal Card.new('2',:hearts),   hand[0]
    assert_equal Card.new('4',:spades),   hand[1]
    assert_equal Card.new('4',:clubs),    hand[2]
    assert_equal Card.new('2',:diamonds), hand[3]
    assert_equal Card.new('4',:hearts),   hand[4]
  end

  def test_card_has_pips_and_suit_set_on_creation
    card = Card.new('2',:hearts)
    assert_equal '2', card.pips
    assert_equal :hearts, card.suit
    card = Card.new('T',:hearts)
    assert_equal 'T', card.pips
    assert_equal :hearts, card.suit
    card = Card.new('J',:hearts)
    assert_equal 'J', card.pips
    assert_equal :hearts, card.suit
    card = Card.new('Q',:hearts)
    assert_equal 'Q', card.pips
    assert_equal :hearts, card.suit
    card = Card.new('K',:hearts)
    assert_equal 'K', card.pips
    assert_equal :hearts, card.suit
    card = Card.new('A',:hearts)
    assert_equal 'A', card.pips
    assert_equal :hearts, card.suit
  end

  def test_hand_ranked_three_of_a_kind
    assert_equal :three_of_a_kind, Hand.new("2H 4S 4C AD 4H").rank
  end

  def test_hand_ranked_one_pair
    assert_equal :one_pair, Hand.new("2H 4S 5C JD 4H").rank
  end

  def test_hand_ranked_two_pairs
    assert_equal :two_pairs, Hand.new("2H 4S 5C 2D 4H").rank
  end

  def test_hand_ranked_flush
    assert_equal :flush, Hand.new("2H 4H 6H 8H TH").rank
  end

  def test_hand_ranked_straight
    assert_equal :straight, Hand.new("2H 3C 4H 5H 6H").rank
  end

  def test_hand_ranked_full_house
    assert_equal :full_house, Hand.new("2H 4S 4C 2D 4H").rank
  end

  def test_hand_ranked_four_of_a_kind
    assert_equal :four_of_a_kind, Hand.new("2H 4S 4C 4D 4H").rank
  end

  def test_hand_ranked_straight_flush
    assert_equal :straight_flush, Hand.new("2H 4H 3H 5H 6H").rank
  end

  def test_hand_ranked_high_card
    assert_equal :high_card, Hand.new("2C 3H 4S 8C AH").rank
  end

  def test_full_house_beats_flush
    black = Hand.new("2H 4S 4C 2D 4H")    
    white = Hand.new("2S 8S AS QS 3S")
    assert_equal 1, black <=> white
  end

  def test_higher_card_wins_if_equal_rank
    black = Hand.new("2H 3D 5S 9C KD")
    assert_equal :high_card, black.rank
    white = Hand.new("2C 3H 4S 8C AH")
    assert_equal :high_card, white.rank
    assert_equal -1, black <=> white
  end

  def test_equal_hands
    black = Hand.new("2H 3D 5S 9C KD")
    assert_equal :high_card, black.rank
    white = Hand.new("2D 3H 5C 9S KH")
    assert_equal :high_card, white.rank
    assert_equal 0, black <=> white
  end

end