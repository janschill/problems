require_relative 'node'

module DataStructures
  class Stack
    attr_accessor :head
    attr_reader :length

    def initialize
      @length = 0
    end

    def push(item)
      node = Node.new(item, nil)
      node.next = @head
      @head = node
      @length += 1
    end

    def pop
      return if @head.nil?
      node = @head
      @head = node.next
      @length -= 1
      node
    end

    def peek
      @head
    end

    def clear
      while peek
        pop
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
