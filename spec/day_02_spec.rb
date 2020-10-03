require_relative "../lib/day_02"
require "pry"

RSpec.describe Day02 do
  context "part 1" do
    it "returns the correct answers for the input file" do
      expect(Day02.run_program[0]).to eq 4023471
    end
  end

  context "part 2" do
    it "returns the correct answers for the input file" do
      expect(Day02.find_noun_and_verb_by_output(19690720)).to eq 8051
    end
  end
end
