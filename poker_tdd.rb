require_relative 'poker.rb'
require 'test/unit'

class TestUntitled < Test::Unit::TestCase

  def test_start
    black = ["2H", "3H", "4H", "6H", "KH"]
    white = ["9H", "8S", "7D", "2D", "QS"]
    
    assert_equal :flush, Hand.new(black, white).rank
  end

  
end