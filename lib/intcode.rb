class Intcode
  attr_reader :output

  def initialize(program)
    @mutated_program = program.dup
    @current_address = 0
    @relative_base = 0
    @output = []
  end

  def run(input=[])
    loop do
      abcde = @mutated_program[@current_address].to_s.rjust(5).split("").map(&:to_i)
      param_3_mode, param_2_mode, param_1_mode, opcode_mode, opcode = abcde

      if opcode == 9 && opcode_mode == 9
        if @output.length > 0
          return @output
        else
          return @mutated_program
        end
      end

      return false if process_instruction(opcode, param_1_mode, param_2_mode, param_3_mode, input) == false
    end
  end

  def process_instruction(opcode, param_1_mode, param_2_mode, param_3_mode, input)
    param_1 = @mutated_program[@current_address + 1]
    param_2 = @mutated_program[@current_address + 2]
    param_3 = @mutated_program[@current_address + 3]

    value_1 = read_value(param_1, param_1_mode)
    value_2 = read_value(param_2, param_2_mode)

    case opcode
    when 1
      write_value(param_3, param_3_mode, value_1 + value_2)
      @current_address += 4
    when 2
      write_value(param_3, param_3_mode, value_1 * value_2)
      @current_address += 4
    when 3
      return false if input.empty?
      write_value(param_1, param_1_mode, input.shift)
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
      write_value(param_3, param_3_mode, value_1 < value_2 ? 1 : 0)
      @current_address += 4
    when 8
      write_value(param_3, param_3_mode, value_1 == value_2 ? 1 : 0)
      @current_address += 4
    when 9
      @relative_base += value_1
      @current_address += 2
    else
      raise "invalid opcode"
    end

    true
  end

  def read_value(param, param_mode)
    case param_mode
    when 0
      expand_memory_if_needed!(param)
      @mutated_program[param]
    when 1
      param
    when 2
      location = @relative_base + param
      expand_memory_if_needed!(location)
      @mutated_program[location]
    else
      raise "invalid param mode"
    end
  end

  def write_value(param, param_mode, value)
    case param_mode
    when 0
      expand_memory_if_needed!(param)
      @mutated_program[param] = value
    when 1
      raise "cannot write instructions in immediate mode"
    when 2
      location = @relative_base + param
      expand_memory_if_needed!(location)
      @mutated_program[location] = value
    else
      raise "invalid param mode"
    end
  end

  def expand_memory_if_needed!(location)
    if location >= @mutated_program.length
      (@mutated_program.length..location).each do |index|
        @mutated_program[index] = 0
      end
    end
  end
end
