module Problems
  class RotatingCipher
    def self.tests
      [
        { input: ["abc", 0], output: "abc" },
        { input: ["abc", 2], output: "cde" },
        { input: ["z", 1], output: "a" },
        { input: ["Z-9", 1], output: "A-0" },
      ]
    end

    def self.is_alphanumeric(c)
      !c.match(/\A[a-zA-Z0-9]*\z/).nil?
    end

    def self.solve(s, shift)
      return s if shift.zero?
      return s if s.nil?
      abc = (10..35).map { |i| i.to_s 36 }
      numerics = (0..9).map { |i| i.to_s 36 }
      s.chars.map_with_index do |c, i|
        index = abc[c.lowcase] + shift % abc.length if c.
        abc
      end


    end
  end
end
