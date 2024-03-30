require_relative 'stack'

module DataStructures
  module Trie
    class Node
      attr_accessor :children, :end_of_word

      def initialize
        @children = {}
        @end_of_word = false
      end
    end

    class Trie
      attr_reader :root

      def initialize
        @root = Node.new
      end

      def insert(word)
        current = @root
        word.chars.each do |c|
          current = current.children[c] ||= Node.new
        end
        current.end_of_word = true
      end

      def search(word)
        current = @root
        word.chars.each do |c|
          return false unless current.children[c]
          current = current.children[c]
        end
        current.end_of_word
      end

      # Find all words in the Trie that start with a given prefix
      def starts_with(prefix)
        return if @root.children == {} || prefix.nil?

        words = []
        current = @root
        prefix.chars.each do |c|
          if current.children[c]
            current = current.children[c]
          end
        end

        dfs(current, prefix)
      end

      alias_method :autocomplete, :starts_with

      def delete(word)
        stack = DataStructures::Stack.new
        current = @root
        word.chars.each do |c|
          return unless current.children[c]
          current = current.children[c]
          stack.push([c, current])
        end
        current.end_of_word = false
        while item = stack.pop
          c, n = item.value
          return if n && (n.end_of_word || n.children.any?)
          _, parent = stack.peek&.value
          parent.children.delete(c) if parent
        end
      end

      private

      def dfs(node, prefix)
        words = []
        words << prefix if node.end_of_word
        node.children.each { |k, v| words += dfs(v, prefix + k) }
        words
      end
    end

    def self.new
      Trie.new
    end
  end
end
