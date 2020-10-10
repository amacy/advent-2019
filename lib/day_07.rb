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

  def self.highest_signal_on_feedback_loop(program = parse_file)
    signals = []
    (5..9).to_a.permutation.map do |phase_setting_sequence|
      a = Intcode.new(program.dup)
      b = Intcode.new(program.dup)
      c = Intcode.new(program.dup)
      d = Intcode.new(program.dup)
      e = Intcode.new(program.dup)

      a.run([phase_setting_sequence[0], 0])
      b.run([phase_setting_sequence[1], a.output[0]])
      c.run([phase_setting_sequence[2], b.output[0]])
      d.run([phase_setting_sequence[3], c.output[0]])

      result = e.run([phase_setting_sequence[4], d.output[0]])

      loop do
        break signals << e.output[-1] if result

        a.run([e.output[-1]])
        b.run([a.output[-1]])
        c.run([b.output[-1]])
        d.run([c.output[-1]])
        result = e.run([d.output[-1]])
      end
    end

    signals.max
  end

  def self.parse_file
    File.readlines("config/day_07.txt")[0].split(",").map(&:to_i)
  end
end
