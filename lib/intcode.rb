class Intcode
  def self.run(program, input=[])
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

      value_1 = value(param_1, param_1_mode, old_program)
      value_2 = value(param_2, param_2_mode, old_program)

      case opcode
      when 1
        new_program[param_3] = value_1 + value_2
        current_address += 4
      when 2
        new_program[param_3] = value_1 * value_2
        current_address += 4
      when 3
        new_program[param_1] = input.shift
        current_address += 2
      when 4
        output << value_1
        current_address += 2
      when 5
        if value_1 != 0
          current_address = value_2
        else
          current_address += 3
        end
      when 6
        if value_1 == 0
          current_address = value_2
        else
          current_address += 3
        end
      when 7
        new_program[param_3] = value_1 < value_2 ? 1 : 0
        current_address += 4
      when 8
        new_program[param_3] = value_1 == value_2 ? 1 : 0
        current_address += 4
      else
        raise "invalid opcode"
      end

      old_program = new_program.dup
    end
  end

  def self.value(param, param_mode, program)
    case param_mode
    when 0
      program[param]
    when 1
      param
    else
      raise "invalid param mode"
    end
  end
end
