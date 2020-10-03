class Day04
  def self.possible_passwords(input="158126-624574")
    input = input.split("-")

    (input[0]..input[1]).select do |n|
      valid_password?(n)
    end.count
  end

  def self.valid_password?(str)
    valid_length?(str) &&
      ascending?(str) &&
      contains_double?(str)
  end

  def self.valid_length?(str)
    str.length == 6
  end

  def self.ascending?(str)
    index = 0
    loop do
      break true if index == str.length - 1
      head = str[index]
      tail = str[index + 1..-1].split("")
      return false if tail.any? { |n| n.to_i < head.to_i }
      index += 1
    end
  end

  def self.contains_double?(str)
    index = 0
    loop do
      return false if index == str.length - 1
      break true if str[index] == str[index + 1]
      index += 1
    end
  end
end
