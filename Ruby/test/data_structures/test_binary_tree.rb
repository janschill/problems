require 'maxitest/autorun'
require_relative '../../data_structures/binary_tree'

class TestBinaryTree < Minitest::Test
  include DataStructures::Trees

  def test_init_binary_tree
    bt = BinaryTree.new(Node.new)
    assert_equal bt.size, 1
  end

  def test_insert_left
    bt = BinaryTree.new(Node.new(nil, 1))
    bt.insert_left(bt.root, 2)
    assert_equal bt.size, 2
    assert_equal bt.root.left.parent, bt.root
    assert_equal bt.root.left.value, 2
  end

  def test_insert_right
    bt = BinaryTree.new(Node.new(nil, 1))
    bt.insert_right(bt.root, 2)
    assert_equal bt.size, 2
    assert_equal bt.root.right.parent, bt.root
    assert_equal bt.root.right.value, 2
  end

  def test_remove_left
    bt = BinaryTree.new(Node.new(nil, 1))
    bt.insert_left(bt.root, 2)
    bt.insert_right(bt.root.left, 5)
    bt.insert_right(bt.root, 3)
    assert_equal bt.size, 4
    bt.remove_left(bt.root)
    assert_equal bt.size, 2
  end

  def test_remove_right
    bt = BinaryTree.new(Node.new(nil, 1))
    bt.insert_left(bt.root, 2)
    bt.insert_right(bt.root.left, 5)
    bt.insert_right(bt.root, 3)
    assert_equal bt.size, 4
    bt.remove_right(bt.root)
    assert_equal bt.size, 3
  end

  def test_merge
    bt1 = BinaryTree.new(Node.new(nil, 1))
    bt1.insert_left(bt1.root, 4)
    bt1.insert_right(bt1.root, 5)
    assert_equal bt1, BinaryTree.merge(bt1, nil)
    assert_equal bt1, BinaryTree.merge(nil, bt1)
    bt2 = BinaryTree.new(Node.new(nil, 2))
    bt2.insert_left(bt2.root, 6)
    bt2.insert_right(bt2.root, 3)
    merged_tree = BinaryTree.merge(bt1, bt2, 1)
    assert_equal bt1.size + bt2.size, merged_tree.size
    assert_equal 1, merged_tree.root.value
    assert_equal bt1.root.value, merged_tree.root.left.value
    assert_equal bt2.root.value, merged_tree.root.right.value
  end

  def test_add_with_empty_trees
    bt1 = BinaryTree.new
    bt2 = BinaryTree.new
    tree = BinaryTree.add(bt1, bt2)
    assert_nil tree.root
  end

  def test_add_with_one_empty_tree
    bt1 = BinaryTree.new(Node.new(nil, 1))
    bt1.insert_left(bt1.root, 4)
    bt1.insert_right(bt1.root, 5)
    bt2 = BinaryTree.new
    tree = BinaryTree.add(bt1, bt2)
    assert_equal 1, tree.root.value
    assert_equal 4, tree.root.left.value
    assert_equal 5, tree.root.right.value
  end

  def test_add_with_trees_of_different_sizes
    bt1 = BinaryTree.new(Node.new(nil, 1))
    bt1.insert_left(bt1.root, 4)
    bt1.insert_right(bt1.root, 5)
    bt2 = BinaryTree.new(Node.new(nil, 2))
    tree = BinaryTree.add(bt1, bt2)
    assert_equal 3, tree.root.value
    assert_equal 4, tree.root.left.value
    assert_equal 5, tree.root.right.value
  end

  def test_print
  end
end
