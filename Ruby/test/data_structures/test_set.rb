require 'maxitest/autorun'
require_relative '../../data_structures/set'

class TestSet < Minitest::Test
  include DataStructures

  def test_insert
    set = Set.new
    set.insert(1)
    assert set.contains?(1)
  end

  def test_remove
    set = Set.new
    set.insert(1)
    assert_equal 1, set.count
    set.remove(1)
    assert_equal 0, set.count
  end

  def test_union
    set = Set.new([1, 2, 3])
    other = Set.new([3, 4, 5])
    union_set = set.union(other)
    assert_equal [1, 2, 3, 4, 5], union_set.to_a.sort
  end

  def test_intersect
    set = Set.new([1, 2, 3])
    other = Set.new([3, 4, 5])
    intersect_set = set.intersect(other)
    assert_equal [3], intersect_set.to_a.sort
  end

  def test_diff
    current = Set.new([1, 2, 3])
    other = Set.new([3, 4, 5])
    diff_set = current.diff(other)
    assert_equal [1, 2], diff_set.to_a.sort
  end

  def test_contains?
    current = Set.new([1, 2, 3])
    assert_equal true, current.contains?(2)
    assert_equal false, current.contains?(5)
    assert_equal false, current.contains?(nil)
  end

  def test_subset?
    assert_equal true, Set.new([]).subset?(Set.new([1, 2, 3]))
    assert_equal true, Set.new([2, 3]).subset?(Set.new([1, 2, 3]))
    assert_equal false, Set.new([2, 3, 4]).subset?(Set.new([1, 2, 3]))
  end

  def test_equal?
    assert_equal true, Set.new([]).equal?(Set.new([]))
    assert_equal true, Set.new([1, 2, 3]).equal?(Set.new([1, 2, 3]))
    assert_equal false, Set.new([1, 2, 3]).equal?(Set.new([]))
    assert_equal false, Set.new([1, 2, 3]).equal?(Set.new([1]))
  end

  def test_count
  end

  def test_each
  end

  def test_print
  end
end
