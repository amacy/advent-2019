class Intcode
  def self.run(list)
    new_list = list.dup
    old_list = list.dup
    current_address = 0
    loop do
      opcode = old_list[current_address]
      return old_list if opcode == 99


      if opcode == 1
        parameter_to_read_1 = old_list[current_address + 1]
        parameter_to_read_2 = old_list[current_address + 2]
        parameter_to_write = old_list[current_address + 3]

        value_1 = old_list[parameter_to_read_1]
        value_2 = old_list[parameter_to_read_2]
        value_3 = value_1 + value_2

        new_list[parameter_to_write] = value_3

        current_address += 4
      elsif opcode == 2
        parameter_to_read_1 = old_list[current_address + 1]
        parameter_to_read_2 = old_list[current_address + 2]
        parameter_to_write = old_list[current_address + 3]

        value_1 = old_list[parameter_to_read_1]
        value_2 = old_list[parameter_to_read_2]
        value_3 = value_1 * value_2

        new_list[parameter_to_write] = value_3

        current_address += 4
      elsif opcode == 3
        parameter_to_write = old_list[current_address + 1]
        input = old_list[current_address + 2]

        new_list[parameter_to_write] = input
      elsif opcode == 4
        parameter_to_read = old_list[current_address + 1]
        old_list[parameter_to_read]
      else
        raise "something went wrong"
      end

      old_list = new_list.dup
    end
  end
end
