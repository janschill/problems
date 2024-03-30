module DataStructures
  class Slot
    attr_accessor :key, :value, :vacated

    alias_method :vacated?, :vacated

    def initialize(key, value)
      self.key = key
      self.value = value
      self.vacated = false
    end

    def free
      self.value   = nil
      self.vacated = true
    end
  end

  class HashTable
    attr_accessor :size

    def initialize
      @slots = 5
      fill_table(@slots)
      self.size = 0
      @rebuilds = 0
      @h1 = -> (k) { k % @slots }
      @h2 = -> (k) { 1 + (k % (@slots - 1)) }
    end

    def put(key, value)
      if (slot = find_slot(key))
        slot.value = value
        return
      end

      rebuild if self.size > (@slots / 2)

      0.upto(@slots - 1) do |i|
        index = double_hash(key.hash, i)
        slot = @table[index]
        if slot.nil? || slot.vacated?
          @table[index] = Slot.new(key, value)
          self.size += 1
          return
        end
      end
    end

    def get(key)
      0.upto(@slots - 1) do |i|
        index = double_hash(key.hash, i)
        slot = @table[index]
        return nil if slot.nil? || slot.vacated?
        return slot.value if slot.key == key
      end
      nil
    end

    def remove(key)
      0.upto(@slots - 1) do |i|
        index = double_hash(key.hash, i)
        slot = @table[index]
        unless slot.nil?
          slot.free
          self.size -= 1
        end
      end
    end

    def contains?(key)
      0.upto(@slots - 1) do |i|
        index = double_hash(key.hash, i)
        slot = @table[index]
        return true unless slot.nil? || slot.value.nil? && slot.vacated?
      end
      false
    end

    def empty?
      self.size == 0
    end

    def print
    end

    private

    def double_hash(hashcode, index)
      h1 = @h1.call(hashcode)
      h2 = @h2.call(hashcode)
      ((h1 + (index * h2)) % @slots).abs()
    end

    def find_slot(key)
      0.upto(@slots - 1) do |i|
        index = double_hash(key.hash, i)
        slot = @table[index]
        return nil if slot.nil?
        return slot if slot.key == key
      end
      nil
    end

    PRIMES = [13, 31, 61, 127, 251, 509]
    MAX_REBUILDS = 6

    def rebuild
      if @rebuilds >= MAX_REBUILDS
        raise "Too many entries"
      end

      old = @table
      @slots = PRIMES[@rebuilds]
      self.size = 0
      fill_table(@slots)
      old.each do |e|
        put(e.key, e.value) if e
      end
      @rebuilds += 1
    end

    def fill_table(slots)
      @table = []
      0.upto(slots - 1) { @table << nil }
    end
  end
end
