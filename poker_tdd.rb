require "minitest/autorun"
require_relative "poker.rb"

class TestIsbn < Minitest::Test
    def test_if_equal
        assert_equal(1,1)
    end

    def test_if_deck_is_array
        deck = Deck.new
        assert_equal(Array, deck.cards.class)
    end
end
