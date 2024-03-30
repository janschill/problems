require 'maxitest/autorun'
require_relative '../../data_structures/linked_list' # Adjust the path as per your project structure

class TestLinkedList < Minitest::Test
  include DataStructures

  def setup
    @list = LinkedList.new
  end

  def test_insert
    @list.insert(5)
    assert_equal 1, @list.length
    assert_equal 5, @list.head.value
    assert_nil @list.search(10)
    assert_equal 5, @list.search(5).value
  end

  def test_print
    [4,3,2,1].each { |val| @list.insert(val) }
    assert_equal [1,2,3,4], @list.print
  end

  def test_empty_list
    assert_equal true, @list.empty?
    assert_equal 0, @list.length
    assert_nil @list.peek
    assert_nil @list.search(5)
  end

  def test_reverse
    values = [1, 2, 3, 4]
    values.each { |val| @list.insert(val) }

    @list.reverse

    values.each do |val|
      assert_equal val, @list.peek.value
      @list.delete(val)
    end

    assert_equal true, @list.empty?
  end

  def test_delete
    [1, 2, 3, 4].each { |val| @list.insert(val) }

    assert_equal 4, @list.length
    assert_equal 3, @list.search(3).value

    @list.delete(3)

    assert_equal 3, @list.length
    assert_nil @list.search(3)
  end

  def test_count
    assert_equal 0, @list.count
    assert_equal 0, @list.count(:iterative)

    [1, 2, 3, 4].each { |val| @list.insert(val) }

    assert_equal 4, @list.count
    assert_equal 4, @list.count(:iterative)

    @list.delete(2)

    assert_equal 3, @list.count
    assert_equal 3, @list.count(:iterative)
  end

  def test_search
    [1, 2, 3, 4].each { |val| @list.insert(val) }

    assert_equal 2, @list.search(2).value
    assert_equal 2, @list.search(2, :iterative).value
    assert_nil @list.search(5)
    assert_nil @list.search(5, :iterative)
  end

  def test_to_a
    a = [1, 2, 3, 4]
    l = LinkedList.new(a)
    assert_equal a.sort, l.to_a.sort
  end

  def test_all?
    l = LinkedList.new([2, 4, 6])
    assert_equal true, l.all?(&:even?)
    assert_equal false, l.all?(&:odd?)
  end

  def test_length
    l = LinkedList.new([])
    assert_equal 0, l.length
    l.insert(1)
    l.insert(2)
    assert_equal 2, l.length
    l.delete(1)
    assert_equal 1, l.length
    assert_equal 3, LinkedList.new([1, 2, 3]).length
  end
end
