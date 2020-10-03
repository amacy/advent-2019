require_relative "../lib/day_04"
require "pry"

RSpec.describe Day04 do
  context "part 1" do
    it "finds possible passwords" do
      expect(Day04.valid_password_part_1?("11111")).to eq false
      expect(Day04.valid_password_part_1?("1111111")).to eq false
      expect(Day04.valid_password_part_1?("111111")).to eq true
      expect(Day04.valid_password_part_1?("111123")).to eq true
      expect(Day04.valid_password_part_1?("122345")).to eq true
      expect(Day04.valid_password_part_1?("223450")).to eq false
      expect(Day04.valid_password_part_1?("123789")).to eq false
    end

    it "returns the correct answers for the input" do
      expect(Day04.possible_passwords_part_1).to eq 1665
    end
  end

  context "part 2" do
    it "finds possible passwords" do
      expect(Day04.valid_password_part_2?("12355")).to eq false
      expect(Day04.valid_password_part_2?("1234566")).to eq false
      expect(Day04.valid_password_part_2?("112233")).to eq true
      expect(Day04.valid_password_part_2?("111122")).to eq true
      expect(Day04.valid_password_part_2?("112222")).to eq true
      expect(Day04.valid_password_part_2?("123345")).to eq true
      expect(Day04.valid_password_part_2?("123444")).to eq false
      expect(Day04.valid_password_part_2?("223450")).to eq false
      expect(Day04.valid_password_part_2?("123789")).to eq false
    end

    it "returns the correct answers for the input" do
      expect(Day04.possible_passwords_part_2).to eq 1131
    end
  end
end
