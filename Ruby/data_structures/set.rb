require_relative 'linked_list'

module DataStructures
  attr_reader :length

  class Set
    def initialize(array = [])
      @list = DataStructures::LinkedList.new
      array.each { |e| insert(e) }
    end

    def insert(member)
      @list.insert(member) unless contains?(member)
    end

    def remove(member)
      @list.delete(member)
    end

    # Return set with elements from both sets
    def union(other)
      new_set = Set.new
      each { |e| new_set.insert(e.value) }
      other.each { |o| new_set.insert(o.value) }
      new_set
    end

    # Return set with elements intersecting with other set
    # [3, 1, 2] ∩ [1, 4] = [1]
    def intersect(other)
      new_set = Set.new
      each { |e| new_set.insert(e.value) if other.contains?(e.value) }
      new_set
    end

    # Return set with elements not in other set
    def diff(other)
      new_set = Set.new
      each { |e| new_set.insert(e.value) unless other.contains?(e.value) }
      new_set
    end

    def contains?(member)
      @list.contains?(member)
    end

    def subset?(other)
      all? { |e| other.contains?(e) }
    end

    def equal?(other)
      return false unless count == other.count
      subset?(other)
    end

    def count
      @list.length
    end

    def each(&block)
      @list.each(&block)
    end

    def all?(&block)
      @list.all?(&block)
    end

    def print
      raise "Not implemented"
    end

    def to_a
      @list.to_a
    end
  end
end
