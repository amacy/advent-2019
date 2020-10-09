require_relative "../lib/day_06"
require "pry"

RSpec.describe Day06 do
  context "part 1" do
    it "returns the correct number of orbits for the sample input" do
      input = %w[ COM)B B)C C)D D)E E)F B)G G)H D)I E)J J)K K)L ]
      expect(Day06.orbits(input)).to eq 42
    end

    it "returns the correct number of orbits for the puzzle input" do
      expect(Day06.orbits).to eq 241064
    end
  end

  context "part 2" do
    it "returns the correct answers for the input file" do
      # expect(Day06.orbits([5])[0]).to eq 5000972
    end
  end
end
