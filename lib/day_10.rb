require "set"

class Day10
  Asteroid = Struct.new(
    :column_number,
    :row_number,
    :obscured_locations,
    :obscured_asteroid_locations,
    :visible_asteroid_locations,
  ) do
    def location
      [column_number, row_number]
    end
  end

  def self.best_monitoring_station(map) asteroids = []
    graph = []
    map.each_with_index do |row, row_number|
      graph[row_number] ||= []
      row.split("").each_with_index do |node, column_number|
        if node == "#"
          asteroid = Asteroid.new(
            column_number,
            row_number,
            Set.new([[column_number, row_number]]),
            Set.new,
            Set.new,
          )
          graph[row_number][column_number] = asteroid
          asteroids << asteroid
        end
      end
    end

    populate_obscured_locations!(asteroids, graph.length)

    asteroids.each do |a_1|
      asteroids.each do |a_2|
        if a_1.obscured_locations.include?(a_2.location)
          a_1.obscured_asteroid_locations << a_2.location
        else
          a_1.visible_asteroid_locations << a_2.location
        end
      end
    end

    asteroids.map(&:visible_asteroid_locations).map(&:count).max
  end

  def self.populate_obscured_locations!(asteroids, length)
    head = asteroids[0]
    tail = asteroids[1..-1]
    tail.each do |a|
      if head.row_number == a.row_number
        if head.column_number < a.column_number
          store_locations_for_same_row!(head, a, length)
        else
          store_locations_for_same_row!(a, head, length)
        end
      else # row number of a will never be < head
        if head.column_number == a.column_number
          store_locations_for_same_column!(head, a, length)
        else
          store_locations_for_different_rows_and_columns!(head, a, length)
        end
      end
    end

    populate_obscured_locations!(tail, length) if tail.length > 1
  end

  def self.store_locations_for_same_row!(a_1, a_2, length)
    (a_2.column_number + 1..length - 1).each do |column_number|
      a_1.obscured_locations << [column_number, a_1.row_number]
    end

    (0..a_1.column_number - 1).each do |column_number|
      a_2.obscured_locations << [column_number, a_2.row_number]
    end
  end

  def self.store_locations_for_same_column!(a_1, a_2, length)
    (a_2.row_number + 1..length - 1).each do |row_number|
      a_1.obscured_locations << [a_1.column_number, row_number]
    end

    (0..a_1.row_number - 1).each do |row_number|
      a_2.obscured_locations << [a_2.column_number, row_number]
    end
  end

  def self.store_locations_for_different_rows_and_columns!(a_1, a_2, length)
    row_delta = a_2.row_number - a_1.row_number
    column_delta = a_2.column_number - a_1.column_number

    if row_delta == column_delta
      row_delta = column_delta = 1
    end

    current_row = a_2.row_number + row_delta
    current_column = a_2.column_number + column_delta
    loop do
      break if current_row >= length || current_column < 0

      a_1.obscured_locations << [current_column, current_row]

      current_row += row_delta
      current_column += column_delta
    end

    current_row = a_1.row_number - row_delta
    current_column = a_1.column_number - column_delta
    loop do
      break if current_row < 0 || current_column >= length

      a_2.obscured_locations << [current_column, current_row]

      current_row -= row_delta
      current_column -= column_delta
    end
  end
end
