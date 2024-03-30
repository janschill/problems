module DataStructures
  class Heap
    attr_reader :elements

    def initialize
      # parent: (index - 1) / 2
      # child_left: 2 * index + 1
      # child_right: 2 * index + 2
      @elements = []
    end

    # Adding element to the end of the array
    # Bubble it up: swap with its parent if smaller
    def insert(element)
      @elements << element
      bubble_up(size - 1)
    end

    # Remove and return the minimum element from the heap
    # Swap root and last element
    # Bubble down new root element
    def extract_root
      return nil if empty?
      swap(0, size - 1)
      min = @elements.pop
      bubble_down(0)
      min
    end

    def peek_root
      return nil if empty?
      @elements[0]
    end

    def empty?
      @elements.empty?
    end

    def size
      @elements.size
    end

    def clear
      @elements.clear
    end

    def build_heap(array)
      @elements = []
      array.each do |element|
        insert(element)
      end
    end

    def should_swap(parent_value, child_value)
      raise NotImplementedError, "Subclasses must implement this method"
    end

    private

    def bubble_up(index)
      return if index == 0
      parent_idx = (index - 1) / 2
      if should_swap(@elements[parent_idx], @elements[index])
        swap(index, parent_idx)
        bubble_up(parent_idx)
      end
    end

    def bubble_down(index)
      return if index >= (size - 1)
      child_left_idx = 2 * index + 1
      child_right_idx = 2 * index + 2
      return if child_left_idx >= size # return if there is no left child

      swap_child_idx = child_left_idx
      if child_right_idx < size && should_swap(@elements[child_left_idx], @elements[child_right_idx])
        swap_child_idx = child_right_idx
      end

      if should_swap(@elements[index], @elements[swap_child_idx])
        swap(index, swap_child_idx)
        bubble_down(swap_child_idx)
      end
    end

    def swap(index1, index2)
      @elements[index1], @elements[index2] = @elements[index2], @elements[index1]
    end
  end
end
