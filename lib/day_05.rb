require_relative "intcode"

class Day05
  def self.run_program(list=parse_file)
    Intcode.run(list)
  end

  def self.parse_file
    File.readlines("config/day_05.txt")[0].split(",").map(&:to_i)
  end
end
