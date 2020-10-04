class Intcode
  def self.run(list)
    new_list = list.dup
    old_list = list.dup
    output = []
    current_address = 0
    loop do
      input = 1
      abcde = old_list[current_address].to_s.rjust(5).split("").map(&:to_i)
      param_3_mode, param_2_mode, param_1_mode, opcode_mode, opcode = abcde
      if opcode == 9 && opcode_mode == 9
        if output.length > 0
          return output
        else
          return old_list
        end
      end

      param_1 = old_list[current_address + 1]
      param_2 = old_list[current_address + 2]
      param_3 = old_list[current_address + 3]

      if [1, 2].include?(opcode)
        if param_1_mode == 0
          value_1 = old_list[param_1]
        else
          value_1 = old_list[current_address + 1]
        end

        if param_2_mode == 0
          value_2 = old_list[param_2]
        else
          value_2 = old_list[current_address + 2]
        end

        if opcode == 1
          new_list[param_3] = value_1 + value_2
        else
          new_list[param_3] = value_1 * value_2
        end

        current_address += 4
      elsif opcode == 3
        new_list[param_1] = input

        current_address += 2
      elsif opcode == 4
        output << old_list[param_1]

        current_address += 2
      else
        raise "something went wrong"
      end

      old_list = new_list.dup
    end
  end
end
