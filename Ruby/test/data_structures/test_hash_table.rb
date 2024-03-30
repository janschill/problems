require 'maxitest/autorun'
require_relative '../../data_structures/hash_table'

class TestHashTable < Minitest::Test
  include DataStructures

  def test_init_hash_table
    ht = HashTable.new
    assert ht.size == 0
  end

  def test_add_entry
    ht = HashTable.new
    ht.put("foo", "bar")

    assert ht.get("foo") == "bar"
  end

  def test_update_entry
    ht = HashTable.new
    ht.put("foo", "bar")
    ht.put("foo", "baz")

    assert ht.get("foo") == "baz"
  end

  def test_remove
    ht = HashTable.new
    ht.put("foo", "bar")
    assert ht.get("foo") == "bar"
    ht.remove("foo")
    assert ht.get("foo").nil?
  end

  def test_contains
    ht = HashTable.new
    assert ht.contains?("foo") == false
    ht.put("foo", "bar")
    assert ht.contains?("foo")
    ht.remove("foo")
    assert ht.contains?("foo") == false
  end

  def test_empty?
    ht = HashTable.new
    assert ht.empty?
    ht.put("foo", "bar")
    assert ht.empty? == false
    ht.remove("foo")
    assert ht.empty?
  end

  def test_rebuild_table
    ht = HashTable.new
    ht.put("key1", 1);
    ht.put("key2", 2);
    ht.put("key3", 3);
    ht.put("key4", 4);
    ht.put("key5", 5);
    ht.put("key6", 6);
    ht.put("key7", 7);
    ht.put("key8", 8);
    ht.put("key9", 9);
    ht.put("key10", 10);
    ht.put("key11", 11);

    assert ht.get("key11") == 11
  end
end
