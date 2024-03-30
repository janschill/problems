require_relative 'node'

module DataStructures
  class LinkedList
    attr_accessor :head, :tail
    attr_reader :length

    def initialize(array = [])
      @length = 0
      array.each { |e| insert(e) }
    end

    def peek
      @head
    end

    def insert(v)
      return if v.nil?
      new_node = Node.new(v, @head)
      @head = new_node
      @length += 1
    end

    def clear
      raise StandardError, "Not implemented"
    end

    def cat(list)
      raise StandardError, "Not implemented"
    end

    def each
      return unless block_given?
      return unless self.length > 0

      current = self.head
      while current
        yield current
        current = current.next
      end
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

    alias_method :to_a, :print

    def delete(value)
      return unless @head
      return unless value
      return unless @length > 0

      if @head.value == value
        @head = @head.next
        @length -= 1
        return
      end

      node = @head
      while node.next
        if node.next.value == value
          node.next = node.next.next
          @length -= 1
          return
        end
        node = node.next
      end
    end

    def reverse
      prev = nil
      current = @head
      while current
        nxt = current.next
        current.next = prev
        prev = current
        current = nxt
      end
      @head = prev
    end

    def count(mode = :recursive)
      case mode
      when :recursive
        return length_recursive(0, @head)
      else
        return length_iterative
      end
    end

    def empty?
      return @head.nil?
    end

    def search(v, mode = :recursive)
      case mode
      when :recursive
        return search_recurise(v, @head)
      else
        return search_iterative(v)
      end
    end

    def contains?(v)
      !search(v).nil?
    end

    def all?
      return false unless block_given?
      return true if @head.nil?

      current = @head
      while current
        return false unless yield(current.value)
        current = current.next
      end
      true
    end

    private

    def search_iterative(v)
      node = @head
      while node
        return node if node.value == v
        node = node.next
      end
      return nil
    end

    def search_recurise(v, node)
      return nil if node.nil?
      return node if node&.value == v

      search_recurise(v, node&.next)
    end

    def length_recursive(length, node)
      return length if node.nil?
      return length_recursive(length += 1, node&.next)
    end

    def length_iterative
      node = @head
      length = 0
      while node
        length += 1
        node = node.next
      end
      length
    end
  end
end
