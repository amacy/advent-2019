require_relative "../lib/day_08"
require "pry"

RSpec.describe Day08 do
  context "part 1" do
    it "works for the input file" do
      expect(Day08.verify_image(25, 6)).to eq 2016
    end
  end

  context "part 2" do
    it "works for the sample input" do
      expect(Day08.decode_image(2, 2, "0222112222120000")).to eq [" 1", "1 "]
    end

    it "works for the input file" do
      expect(Day08.decode_image(25, 6)).to eq [
        "1  1 1111  11  1111 1  1 ",
        "1  1    1 1  1    1 1  1 ",
        "1111   1  1      1  1  1 ",
        "1  1  1   1     1   1  1 ",
        "1  1 1    1  1 1    1  1 ",
        "1  1 1111  11  1111  11  ",
      ]
    end
  end
end
