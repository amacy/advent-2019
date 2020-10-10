require_relative "intcode"

class Day07
  def self.highest_signal(program = parse_file)
    (0..4).to_a.permutation.map do |phase_setting_sequence|
      a = Intcode.new(program.dup)
      b = Intcode.new(program.dup)
      c = Intcode.new(program.dup)
      d = Intcode.new(program.dup)
      e = Intcode.new(program.dup)

      a.run([phase_setting_sequence[0], 0])
      b.run([phase_setting_sequence[1], a.output[0]])
      c.run([phase_setting_sequence[2], b.output[0]])
      d.run([phase_setting_sequence[3], c.output[0]])
      e.run([phase_setting_sequence[4], d.output[0]])

      e.output[0]
    end.max
  end

  def self.parse_file
    File.readlines("config/day_07.txt")[0].split(",").map(&:to_i)
  end
end
