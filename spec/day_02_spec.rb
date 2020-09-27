require_relative "../lib/day_02"
require "pry"

RSpec.describe Day02 do
  context "part 1" do
    it "runs the program" do
      expect(Day02.run_program([1,9,10,3,2,3,11,0,99,30,40,50])).to eq [3500,9,10,70,2,3,11,0,99,30,40,50]
      expect(Day02.run_program([1,0,0,0,99])).to eq [2,0,0,0,99]
      expect(Day02.run_program([2,3,0,3,99])).to eq [2,3,0,6,99]
      expect(Day02.run_program([1,1,1,4,99,5,6,0,99])).to eq [30,1,1,4,2,5,6,0,99]
    end

    it "returns the correct answers for the input file" do
      expect(Day02.run_program[0]).to eq 4023471
    end
  end

  context "part 2" do
  end
end
