require_relative "../lib/day_08"
require "pry"

RSpec.describe Day08 do
  context "part 1" do
    it "works for the input file" do
      expect(Day08.parse_image(25, 6)).to eq 2016
    end
  end

  context "part 2" do
    it "works for the sample input"
    it "works for the input file"
  end
end
