require_relative "tree"
require_relative "queue"

module DataStructures
  module Trees
    class BinaryTree < Tree
      def initialize(root = nil)
        super(root)
      end

      # Consider what happens the node
      # already has a child (Internal nodes)
      def insert_left(node, data)
        return unless node
        node.left = Node.new(node, data)
        @size += 1
      end

      def insert_right(node, data)
        return unless node
        node.right = Node.new(node, data)
        @size += 1
      end

      # Consider not deleting all children
      # but to point parent to it
      def remove_left(node)
        return unless node

        if node.left
          remove_left(node.left)
          remove_right(node.left)
          node.left = nil
          @size -= 1
        end
      end

      def remove_right(node)
        return unless node

        if node.right
          remove_left(node.right)
          remove_right(node.right)
          node.right = nil
          @size -= 1
        end
      end

      def self.merge(tree1, tree2, data = nil)
        return tree1 unless tree2
        return tree2 unless tree1
        tree = BinaryTree.new(Node.new(nil, data))
        tree.root.left = tree1.root
        tree.root.right = tree2.root
        tree.size = tree1.size + tree2.size
        tree
      end

      def self.add(tree1, tree2)
        return tree1 unless tree2
        return tree2 unless tree1

        def self.add_nodes(node1, node2)
          return nil unless node1 || node2
          new_node_value = (node1&.value || 0) + (node2&.value || 0)
          new_node = Node.new(nil, new_node_value)
          new_node.left = add_nodes(node1&.left, node2&.left)
          new_node.right = add_nodes(node1&.right, node2&.right)
          new_node
        end

        new_root = add_nodes(tree1.root, tree2.root)
        BinaryTree.new(new_root)
      end

      def print(traversal_type = :depth_first)
        case traversal_type
        when :depth_first
          depth_first_traversal { |node| puts node.value }
        when :breadth_first
          breadth_first_traversal { |node| puts node.value }
        else
          raise ArgumentError, "Invalid traversal type: #{traversal_type}"
        end
      end

      private

      def breadth_first_traversal(node = root, &visit)
        queue = DataStructures::Queue.new

        while node
          visit.call(node)
          queue.enqueue(node.left) if node.left
          queue.enqueue(node.right) if node.right
          node = queue.empty? ? nil : queue.dequeue.value
        end
      end

      def depth_first_traversal(depth_type = :in_order, node = root, &visit)
        case depth_type
        when :in_order
          in_order_traversal(node, &visit)
        when :pre_order
          pre_order_traversal(node, &visit)
        when :post_order
          post_order_traversal(node, &visit)
        end
      end

      def in_order_traversal(node, &visit)
        return if node.nil?

        in_order_traversal(node.left, &visit)
        visit.call(node)
        in_order_traversal(node.right, &visit)
      end

      def pre_order_traversal(node, &visit)
        return if node.nil?

        visit.call(node)
        pre_order_traversal(node.left, &visit)
        pre_order_traversal(node.right, &visit)
      end

      def post_order_traversal(node, &visit)
        return if node.nil?

        post_order_traversal(node.left, &visit)
        post_order_traversal(node.right, &visit)
        visit.call(node)
      end
    end
  end
end
