require_relative "../lib/day_09"
require "pry"

RSpec.describe Day09 do
  context "part 1" do
    it "works for the input file" do
      expect(Day09.boost_keycode).to eq 3235019597
    end
  end

  context "part 2" do
    it "works for the input file" do
      expect(Day09.boost_keycode(2)).to eq 80274
    end
  end
end
