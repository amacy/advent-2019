require "intcode"

class Day09
  def self.boost_keycode(mode=1)
    Intcode.new(parse_file).run([mode])[0]
  end

  def self.parse_file
    File.readlines("config/day_09.txt")[0].split(",").map(&:to_i)
  end
end
