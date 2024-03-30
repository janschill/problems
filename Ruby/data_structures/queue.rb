require_relative 'node'

module DataStructures
  class Queue
    attr_accessor :head, :tail
    attr_reader :length

    def initialize
      @length = 0
    end

    def enqueue(value)
      new_node = Node.new(value, nil)
      @head = @tail = new_node if @head.nil? && @tail.nil?

      node = @tail
      node.next = new_node
      @tail = new_node
      @length += 1
    end

    def dequeue
      node = @head
      if node
        @head = node.next
        @length -= 1
      end
      return node
    end

    def peek
      @head
    end

    def clear
      while peek
        dequeue
      end
    end

    def each
      raise "Not implemented"
    end

    def empty?
      @head.nil?
    end

    def print
      s = []
      node = @head
      while node
        s << node.value
        node = node.next
      end
      s
    end
  end
end
