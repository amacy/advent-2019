class Day02
  def self.run_program(list=parse_file)
    new_list = list.dup
    old_list = list.dup
    index = 0
    loop do
      opcode = old_list[index]
      return old_list if opcode == 99

      position_1 = old_list[index + 1]
      position_2 = old_list[index + 2]
      position_3 = old_list[index + 3]

      value_1 = old_list[position_1]
      value_2 = old_list[position_2]

      if opcode == 1
        value_3 = value_1 + value_2
      elsif opcode == 2
        value_3 = value_1 * value_2
      else
        raise "something went wrong"
      end

      new_list[position_3] = value_3
      old_list = new_list.dup
      index += 4
    end
  end

  def self.parse_file(noun=12, verb=2)
    list = File.readlines("config/day_02.txt")[0].split(",").map(&:to_i)
    list[1] = noun
    list[2] = verb
    list
  end

  def self.find_noun_and_verb_by_output(desired_output)
    range = 0..99
    range.each do |noun|
      range.each do |verb|
        input = parse_file(noun, verb)
        if run_program(input)[0] == desired_output
          return (100 * noun) + verb
        end
      end
    end
  end
end
