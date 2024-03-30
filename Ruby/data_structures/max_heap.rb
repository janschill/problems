require_relative "heap"

module DataStructures
  class MaxHeap < Heap
    alias extract_max extract_root
    alias peek_max peek_root

    private

    def should_swap(parent_value, child_value)
      parent_value < child_value
    end
  end
end
