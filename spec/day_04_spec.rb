require_relative "../lib/day_04"
require "pry"

RSpec.describe Day04 do
  context "part 1" do
    it "finds possible passwords" do
      expect(Day04.valid_password?(11111)).to eq false
      expect(Day04.valid_password?(1111111)).to eq false
      expect(Day04.valid_password?(111111)).to eq true
      expect(Day04.valid_password?(111123)).to eq true
      expect(Day04.valid_password?(122345)).to eq true
      expect(Day04.valid_password?(223450)).to eq false
      expect(Day04.valid_password?(123789)).to eq false
    end

    it "returns the correct answers for the input" do
      expect(Day04.possible_passwords).to eq 1665
    end
  end

  context "part 2" do
  end
end
