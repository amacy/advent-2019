require_relative "../lib/day_03"
require "pry"

RSpec.describe Day03 do
  context "part 1" do
    it "runs the program" do
      # expect(Day03.wire_distance(
      #   %w(R8 U5 L5 D3),
      #   %w(U7 R6 D4 L4),
      # )).to eq 6
      expect(Day03.wire_distance(
        %w(R75 D30 R83 U83 L12 D49 R71 U7 L72),
        %w(U62 R66 U55 R34 D71 R55 D58 R83),
      )).to eq 159
      expect(Day03.wire_distance(
        %w(R98 U47 R26 D63 R33 U87 L62 D20 R33 U53 R51),
        %w(U98 R91 D20 R16 D67 R40 U7 R15 U6 R7),
      )).to eq 135
    end

    it "returns the correct answers for the input file"
  end

  context "part 2" do
    it "returns the correct answers for the input file"
  end
end
