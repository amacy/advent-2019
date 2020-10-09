require_relative "intcode"

class Day07
  def self.highest_signal(program = parse_file)
    (0..4).to_a.permutation.map do |phase_setting_sequence|
      amp_a = amplifier(program.dup, phase_setting_sequence[0], 0)
      amp_b = amplifier(program.dup, phase_setting_sequence[1], amp_a[0])
      amp_c = amplifier(program.dup, phase_setting_sequence[2], amp_b[0])
      amp_d = amplifier(program.dup, phase_setting_sequence[3], amp_c[0])
      amp_e = amplifier(program.dup, phase_setting_sequence[4], amp_d[0])
      amp_e[0]
    end.max
  end

  def self.parse_file
    File.readlines("config/day_07.txt")[0].split(",").map(&:to_i)
  end

  def self.amplifier(program, phase_signal, prev_amp_output)
    Intcode.run(program, [phase_signal, prev_amp_output])
  end
end
