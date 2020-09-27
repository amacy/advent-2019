require_relative "../lib/day_01"
require "pry"

RSpec.describe Day01 do
  context "part 1" do
    it "calculates the fuel based on the mass" do
      expect(Day01.fuel_needed(12)).to eq 2
      expect(Day01.fuel_needed(14)).to eq 2
      expect(Day01.fuel_needed(1969)).to eq 654
      expect(Day01.fuel_needed(100756)).to eq 33583
    end

    it "returns the correct answers for the input file" do
      expect(Day01.fuel_sum).to eq 3305115
    end
  end

  context "part 2" do
    it "calculates teh fueld based on the mass and the mass of the fuel" do
      expect(Day01.total_fuel_needed(14)).to eq 2
      expect(Day01.total_fuel_needed(1969)).to eq 966
      expect(Day01.total_fuel_needed(100756)).to eq 50346
    end

    it "returns the correct answers for the input file" do
      expect(Day01.total_fuel_sum).to eq 4954799
    end
  end
end
