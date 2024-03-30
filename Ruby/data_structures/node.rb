module DataStructures
  class Node
    attr_accessor :value, :next

    def initialize(value, node)
      @value = value
      @next = node
    end
  end
end
