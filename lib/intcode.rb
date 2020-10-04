class Intcode
  def self.run(program, input=[1])
    new_program = program.dup
    old_program = program.dup
    output = []
    current_address = 0
    loop do
      abcde = old_program[current_address].to_s.rjust(5).split("").map(&:to_i)
      param_3_mode, param_2_mode, param_1_mode, opcode_mode, opcode = abcde
      if opcode == 9 && opcode_mode == 9
        if output.length > 0
          return output
        else
          return old_program
        end
      end

      param_1 = old_program[current_address + 1]
      param_2 = old_program[current_address + 2]
      param_3 = old_program[current_address + 3]

      if [1, 2].include?(opcode)
        if param_1_mode == 0
          value_1 = old_program[param_1]
        else
          value_1 = old_program[current_address + 1]
        end

        if param_2_mode == 0
          value_2 = old_program[param_2]
        else
          value_2 = old_program[current_address + 2]
        end

        if opcode == 1
          new_program[param_3] = value_1 + value_2
        else
          new_program[param_3] = value_1 * value_2
        end

        current_address += 4
      elsif opcode == 3
          new_program[param_1] = input.shift

        current_address += 2
      elsif opcode == 4
        if param_1_mode == 0
          value_1 = old_program[param_1]
        else
          value_1 = param_1
        end
        output << value_1

        current_address += 2
      elsif opcode == 5
        if param_1_mode == 0
          value_1 = old_program[param_1]
        else
          value_1 = param_1
        end

        if param_2_mode == 0
          value_2 = old_program[param_2]
        else
          value_2 = param_2
        end

        if value_1 != 0
          current_address = value_2
        else
          current_address += 3
        end
      elsif opcode == 6
        if param_1_mode == 0
          value_1 = old_program[param_1]
        else
          value_1 = param_1
        end

        if param_2_mode == 0
          value_2 = old_program[param_2]
        else
          value_2 = param_2
        end

        if value_1 == 0
          current_address = value_2
        else
          current_address += 3
        end
      elsif opcode == 7
        if param_1_mode == 0
          value_1 = old_program[param_1]
        else
          value_1 = param_1
        end

        if param_2_mode == 0
          value_2 = old_program[param_2]
        else
          value_2 = param_2
        end

        if value_1 < value_2
          new_program[param_3] = 1
        else
          new_program[param_3] = 0
        end

        current_address += 4
      elsif opcode == 8
        if param_1_mode == 0
          value_1 = old_program[param_1]
        else
          value_1 = param_1
        end

        if param_2_mode == 0
          value_2 = old_program[param_2]
        else
          value_2 = param_2
        end

        if value_1 == value_2
          new_program[param_3] = 1
        else
          new_program[param_3] = 0
        end

        current_address += 4
      else
        raise "something went wrong"
      end

      old_program = new_program.dup
    end
  end
end
