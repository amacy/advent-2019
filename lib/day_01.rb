class Day01
  def self.fuel_needed(mass)
    (mass / 3) - 2
  end

  def self.fuel_sum
    parse_and_sum_file { |mass| fuel_needed(mass) }
  end

  def self.total_fuel_needed(mass)
    mass = mass.dup
    total = 0
    loop do
      return total if mass <= 0
      mass = fuel_needed(mass)
      total += [mass, 0].max
    end
  end

  def self.total_fuel_sum
    parse_and_sum_file { |mass| total_fuel_needed(mass) }
  end

  def self.parse_and_sum_file(&block)
    File.readlines("config/day_01.txt").inject(0) do |sum, line|
      sum += block.call(line.to_i)
    end
  end
end
