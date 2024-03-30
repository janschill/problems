module Problems
  class AvailableSeats
    def self.tests
      [
        { input: [15, 2, 3, [11, 6, 14]], output: 1 },
        { input: [10, 1, 2, [2, 6]], output: 3 },
      ]
    end

    def self.solve(n, k, m, s)
      s.sort! # [6, 11, 14]
      occupied_seats = []
      s.each { |o| occupied_seats << o - k; occupied_seats << o; occupied_seats << o + k }

      available_seats = []


      [*1..n].each do |e|
        # available_seats <<
      end
    end
end
