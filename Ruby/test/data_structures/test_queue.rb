require 'maxitest/autorun'
require_relative '../../data_structures/queue'

class TestQueue < Minitest::Test
  include DataStructures

  def test_enqueue_and_dequeue
    queue = Queue.new
    queue.enqueue(5)
    queue.enqueue(3)
    assert_equal 5, queue.dequeue.value
    assert_equal 3, queue.dequeue.value
  end

  def test_init_empty_queue
    q = Queue.new
    assert q.length == 0
  end

  def test_enqueue_items
    q = Queue.new
    q.enqueue "foo"
    q.enqueue "bar"
    assert q.length == 2
  end

  def test_peek_item
    q = Queue.new
    q.enqueue "foo"
    q.enqueue "bar"

    assert q.peek.value == "foo"
  end

  def test_peek_item_on_empty_queue
    q = Queue.new
    assert q.peek.nil?
  end

  def test_dequeue_items
    q = Queue.new
    q.enqueue "foo"
    q.enqueue "bar"
    q.enqueue "baz"

    q.dequeue
    q.dequeue

    assert q.peek.value == "baz"
    assert q.length == 1
  end

  def test_dequeue_from_empty_queue
    q = Queue.new
    q.dequeue
    assert q.length == 0
  end

  def test_clear
    q = Queue.new
    q.enqueue "foo"
    q.enqueue "bar"
    q.enqueue "baz"
    q.clear

    assert q.peek.nil?
    assert q.length == 0
  end
end
