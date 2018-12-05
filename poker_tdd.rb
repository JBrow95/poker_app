require_relative 'poker.rb'
require 'test/unit'

class TestUntitled < Test::Unit::TestCase

  def test_for_flush
    black = ["2H", "3H", "4H", "6H", "KH"]
    white = ["9H", "8S", "7D", "2D", "QS"]
    
    assert_equal :flush, Hand.new(black, white).rank
  end

  def test_for_straight
    black = ["6H", "4H", "3H", "5D", "2H"]
    white = ["9H", "8S", "7D", "2D", "QS"]
    assert_equal :straight, Hand.new(black, white).rank
  end

  def test_for_straight_flush
    black = ["6H", "4H", "3H", "5H", "2H"]
    white = ["9H", "8S", "7D", "2D", "QS"]
    assert_equal :straight_flush, Hand.new(black, white).rank
  end

  def test_for_four_of_a_kind
    black = ["4S", "2S", "2D", "2C", "2H"]
    white = ["9H", "8S", "7D", "3D", "QS"]
    assert_equal :four_of_a_kind, Hand.new(black, white).rank
  end

  def test_for_full_house
    black = ["4S", "2D", "2H", "4C", "2H"]
    white = ["9H", "8S", "7D", "3D", "QS"]
    assert_equal :full_house, Hand.new(black, white).rank
  end

  def test_for_three_of_a_kind
    black = ["4S", "2D", "6H", "6C", "6D"]
    white = ["9H", "8S", "7D", "3D", "QS"]
    assert_equal :three_of_a_kind, Hand.new(black, white).rank
  end

  def test_for_two_pairs
    black = ["2S", "2D", "6H", "4C", "6D"]
    white = ["9H", "8S", "7D", "3D", "QS"]
    assert_equal :two_pairs, Hand.new(black, white).rank
  end

  def test_for_pairs
    black = ["2S", "2D", "6H", "4C", "TD"]
    white = ["9H", "8S", "7D", "3D", "QS"]
    assert_equal :pair, Hand.new(black, white).rank
  end
end