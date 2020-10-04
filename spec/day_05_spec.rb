require_relative "../lib/day_05"
require "pry"

RSpec.describe Day05 do
  context "part 1" do
    it "returns the correct answers for the input file" do
      expect(Day05.run_program[-1]).to eq 13285749
    end
  end

  context "part 2" do
    it "returns the correct answers for the input file"
  end
end
