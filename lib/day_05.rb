require_relative "intcode"

class Day05
  # TODO: this is weird and redundant
  def self.run_program(input=[1], list=parse_file)
    Intcode.run(list, input)
  end

  def self.parse_file
    File.readlines("config/day_05.txt")[0].split(",").map(&:to_i)
  end
end
