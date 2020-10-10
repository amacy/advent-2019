require_relative "intcode"

class Day05
  def self.run_program(input)
    program = parse_file
    Intcode.new(program).run(input)
  end

  def self.parse_file
    File.readlines("config/day_05.txt")[0].split(",").map(&:to_i)
  end
end
