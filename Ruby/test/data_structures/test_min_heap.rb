require 'maxitest/autorun'
require_relative '../../data_structures/min_heap'

class TestMinHeap < Minitest::Test
  def setup
    @heap = DataStructures::MinHeap.new
  end

  def test_insert
    @heap.insert(5)
    assert_equal 1, @heap.size
    @heap.insert(3)
    assert_equal 2, @heap.size
    @heap.insert(1)
    @heap.insert(2)
    @heap.insert(6)
    @heap.insert(5)
    @heap.insert(9)
  end

  def test_insert_and_peek_min
    @heap.insert(5)
    assert_equal 5, @heap.peek_min
    @heap.insert(3)
    assert_equal 3, @heap.peek_min
    @heap.insert(7)
    assert_equal 3, @heap.peek_min
  end

  def test_extract_min
    @heap.insert(5)
    @heap.insert(3)
    @heap.insert(7)
    assert_equal 3, @heap.extract_min
    assert_equal 5, @heap.extract_min
    assert_equal 7, @heap.extract_min
  end

  def test_empty?
    assert @heap.empty?
    @heap.insert(5)
    refute @heap.empty?
  end

  def test_size
    assert_equal 0, @heap.size
    @heap.insert(5)
    assert_equal 1, @heap.size
    @heap.insert(3)
    assert_equal 2, @heap.size
  end

  def test_clear
    @heap.insert(5)
    @heap.insert(3)
    @heap.clear
    assert @heap.empty?
    assert_equal 0, @heap.size
  end

  def test_build_heap
    @heap.build_heap([5, 3, 1, 2, 6, 5, 9])
    assert_equal 7, @heap.size
    assert_equal 1, @heap.peek_min
    assert_equal 1, @heap.extract_min
    assert_equal 2, @heap.extract_min
    assert_equal 3, @heap.extract_min
    assert_equal 5, @heap.extract_min
    assert_equal 5, @heap.extract_min
    assert_equal 6, @heap.extract_min
    assert_equal 9, @heap.extract_min
  end
end
