require_relative "../lib/day_07"
require "pry"

RSpec.describe Day07 do
  context "part 1" do
    it "works for the sample input" do
      expect(Day07.highest_signal([
        3,15,3,16,1002,16,10,16,1,16,15,15,4,15,99,0,0
      ])).to eq 43210

      expect(Day07.highest_signal([
        3,23,3,24,1002,24,10,24,1002,23,-1,23,
        101,5,23,23,1,24,23,23,4,23,99,0,0
      ])).to eq 54321

      expect(Day07.highest_signal([
        3,31,3,32,1002,32,10,32,1001,31,-2,31,1007,31,0,33,
        1002,33,7,33,1,33,31,31,1,32,31,31,4,31,99,0,0,0
      ])).to eq 65210
    end

    it "works for the puzzle input" do
      expect(Day07.highest_signal).to eq 255840
    end
  end

  context "part 2" do
    # it "returns the correct answers for the input file" do
    #   expect(Day07.highest_signal).to eq 5000972
    # end
  end
end
