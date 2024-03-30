require_relative "heap"

module DataStructures
  class MinHeap < Heap
    alias extract_min extract_root
    alias peek_min peek_root

    private

    def should_swap(parent_value, child_value)
      parent_value > child_value
    end
  end
end
