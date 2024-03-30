module DataStructures
  module Trees
    class Tree
      attr_accessor :root, :size

      def initialize(root)
        @root = root
        @size = 1
      end
    end

    class Node
      attr_accessor :parent, :value, :left, :right

      def initialize(parent = nil, value = nil)
        @parent = parent
        @value = value
      end
    end
  end
end
