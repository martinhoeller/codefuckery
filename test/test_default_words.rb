require 'minitest/autorun'
require 'codefuckery'

class DefaultWordsTest < Minitest::Test
  def test_default_words_exists
    refute_empty Codefuckery::DEFAULT_WORDS
  end
end