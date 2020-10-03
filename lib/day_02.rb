require_relative "intcode"

class Day02
  def self.run_program(list=parse_file)
    Intcode.run(list)
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
