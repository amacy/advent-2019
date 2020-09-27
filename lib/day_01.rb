class Day01
  def self.fuel_needed(mass)
    (mass / 3) - 2
  end

  def self.fuel_sum
    input = File.readlines("config/day_01.txt").inject(0) do |sum, line|
      sum += fuel_needed(line.to_i)
    end
  end
end
