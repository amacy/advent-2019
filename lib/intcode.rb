class Intcode
  attr_reader :output

  def initialize(program)
    @mutated_program = program.dup
    @current_address = 0
    @output = []
  end

  def run(input=[])
    loop do
      abcde = @mutated_program[@current_address].to_s.rjust(5).split("").map(&:to_i)
      _param_3_mode, param_2_mode, param_1_mode, opcode_mode, opcode = abcde

      if opcode == 9 && opcode_mode == 9
        if @output.length > 0
          return @output
        else
          return @mutated_program
        end
      end

      process_instruction(opcode, param_1_mode, param_2_mode, input)
    end
  end

  def process_instruction(opcode, param_1_mode, param_2_mode, input)
    param_1 = @mutated_program[@current_address + 1]
    param_2 = @mutated_program[@current_address + 2]
    param_3 = @mutated_program[@current_address + 3]

    value_1 = value(param_1, param_1_mode)
    value_2 = value(param_2, param_2_mode)

    case opcode
    when 1
      @mutated_program[param_3] = value_1 + value_2
      @current_address += 4
    when 2
      @mutated_program[param_3] = value_1 * value_2
      @current_address += 4
    when 3
      @mutated_program[param_1] = input.shift
      @current_address += 2
    when 4
      @output << value_1
      @current_address += 2
    when 5
      if value_1 != 0
        @current_address = value_2
      else
        @current_address += 3
      end
    when 6
      if value_1 == 0
        @current_address = value_2
      else
        @current_address += 3
      end
    when 7
      @mutated_program[param_3] = value_1 < value_2 ? 1 : 0
      @current_address += 4
    when 8
      @mutated_program[param_3] = value_1 == value_2 ? 1 : 0
      @current_address += 4
    else
      raise "invalid opcode"
    end
  end

  def value(param, param_mode)
    case param_mode
    when 0
      @mutated_program[param]
    when 1
      param
    else
      raise "invalid param mode"
    end
  end
end
