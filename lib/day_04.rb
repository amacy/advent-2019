class Day04
  def self.possible_passwords_part_1
    input = parse_input

    (input[0]..input[1]).select do |n|
      valid_password_part_1?(n)
    end.count
  end

  def self.valid_password_part_1?(str)
    valid_length?(str) &&
      ascending?(str) &&
      contains_double_part_1?(str)
  end

  def self.possible_passwords_part_2
    input = parse_input

    (input[0]..input[1]).select do |n|
      valid_password_part_2?(n)
    end.count
  end

  def self.valid_password_part_2?(str)
    valid_length?(str) &&
      ascending?(str) &&
      contains_double_part_2?(str)
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

  def self.contains_double_part_1?(str)
    index = 0
    loop do
      return false if index == str.length - 1
      break true if str[index] == str[index + 1]
      index += 1
    end
  end

  def self.contains_double_part_2?(str)
    index = 0
    loop do
      return false if index == str.length - 1
      next_index = index + 1
      if str[index] == str[next_index]
        prev_index = index - 1
        next_next_index = next_index + 1
        if prev_index < 0 || str[prev_index] != str[index]
          if next_next_index >= str.length || str[next_next_index] != str[index]
            return true
          end
        end
      end
      index += 1
    end
  end

  def self.parse_input
    "158126-624574".split("-")
  end
end
