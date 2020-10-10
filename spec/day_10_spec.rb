require_relative "../lib/day_10"
require "pry"

RSpec.describe Day10 do
  context "part 1" do
    it "works for the input file" do
      map = [
        ".#..#",
        ".....",
        "#####",
        "....#",
        "...##",
      ]
      expect(Day10.best_monitoring_station(map)).to eq 8
    end
  end

  context "part 2" do
    it "works for the input file"
  end
end
