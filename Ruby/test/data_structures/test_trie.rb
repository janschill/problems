require 'maxitest/autorun'
require_relative '../../data_structures/trie'

class TrieTest < Minitest::Test
  def setup
    @trie = DataStructures::Trie.new
  end

  def test_insert_and_search
    @trie.insert('hello')
    assert @trie.search('hello')
    refute @trie.search('world')
  end

  def test_starts_with
    @trie.insert('hello')
    @trie.insert('hell')
    @trie.insert('helium')
    assert_equal ['hello', 'hell'].sort, @trie.starts_with('hell').sort
    assert_equal ['hello', 'hell', 'helium'].sort, @trie.starts_with('he').sort
  end

  def test_delete
    @trie.insert('hello')
    assert @trie.search('hello')
    @trie.delete('hello')
    refute @trie.search('hello')
  end

  def test_insert_empty_string
    @trie.insert('')
    assert @trie.search('')
  end

  def test_search_empty_string
    refute @trie.search('')
  end

  def test_starts_with_empty_string
    @trie.insert('hello')
    @trie.insert('world')
    assert_equal ['hello', 'world'].sort, @trie.starts_with('').sort
  end

  def test_delete_empty_string
    @trie.insert('')
    assert @trie.search('')
    @trie.delete('')
    refute @trie.search('')
  end

  def test_delete_non_existent_word
    @trie.insert('hello')
    assert @trie.search('hello')
    @trie.delete('world') # should not raise an error
    assert @trie.search('hello')
  end

  def test_insert_duplicate_word
    @trie.insert('hello')
    assert @trie.search('hello')
    @trie.insert('hello') # should not raise an error
    assert @trie.search('hello')
  end
end
