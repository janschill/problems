require 'maxitest/autorun'
require_relative '../../data_structures/stack'

class TestStack < Minitest::Test
  include DataStructures

  def test_push_and_pop
    stack = Stack.new
    stack.push(5)
    stack.push(3)
    assert_equal 3, stack.pop.value
    assert_equal 5, stack.pop.value
  end

  def test_init_empty_stack
    s = Stack.new
    assert s.length == 0
  end

  def test_push_items
    s = Stack.new
    s.push "foo"
    s.push "bar"
    assert s.length == 2
  end

  def test_peek_item
    s = Stack.new
    s.push "foo"
    s.push "bar"

    assert s.peek.value == "bar"
  end

  def test_peek_item_on_empty_stack
    s = Stack.new
    assert s.peek.nil?
  end

  def test_pop_items
    s = Stack.new
    s.push "foo"
    s.push "bar"
    s.push "baz"

    s.pop
    s.pop

    assert s.peek.value == "foo"
    assert s.length == 1
  end

  def test_pop_from_empty_stack
    s = Stack.new
    s.pop
    assert s.length == 0
  end

  def test_clear
    s = Stack.new
    s.push "foo"
    s.push "bar"
    s.push "baz"
    s.clear

    assert s.peek.nil?
    assert s.length == 0
  end
end
