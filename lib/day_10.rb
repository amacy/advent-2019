require "set"

class Day10
  Asteroid = Struct.new(:x, :y, :obscured_asteroids)

  def self.best_monitoring_station(map)
    asteroids = []
    graph = []
    map.each_with_index do |row, x|
      graph[x] ||= []
      row.split("").each_with_index do |node, y|
        if node == "#"
          asteroid = Asteroid.new(x, y)
          graph[x][y] = asteroid
          asteroids << asteroid
        end
      end
    end
    length = graph.length

    asteroids.each_with_index do |asteroid_1, index|
      asteroid_1.obscured_asteroids = Set.new
      asteroids[index..-1].each do |asteroid_2|
        asteroid_2.obscured_asteroids ||= Set.new
        if asteroid_1.x == asteroid_2.x
          x = asteroid_1.x
          # asteroid_1 y will always be <= android_2 y due to the order of the arrays
          (0..asteroid_1.y - 1).each do |y|
            node = graph[x][y]
            asteroid_2.obscured_asteroids << node if node
          end

          (asteroid_2.y + 1..length - 1).each do |y|
            node = graph[x][y]
            asteroid_1.obscured_asteroids << node if node
          end
        elsif asteroid_1.y == asteroid_2.y
          y = asteroid_1.y
          if asteroid_1.x > asteroid_2.x
            (0..asteroid_2.x - 1).each do |x|
              node = graph[x][y]
              asteroid_1.obscured_asteroids << node if node
            end

            (asteroid_1.x + 1..length - 1).each do |x|
              node = graph[x][y]
              asteroid_2.obscured_asteroids << node if node
            end
          else
            (0..asteroid_1.x - 1).each do |x|
              node = graph[x][y]
              asteroid_2.obscured_asteroids << node if node
            end

            (asteroid_2.x + 1..length - 1).each do |x|
              node = graph[x][y]
              asteroid_1.obscured_asteroids << node if node
            end
          end
        else
          if asteroid_2.x > asteroid_1.x
            x_delta = asteroid_2.x - asteroid_1.x
            # asteroid_1 y will always be <= android_2 y due to the order of the arrays
            y_delta = asteroid_2.y - asteroid_1.y
            x = asteroid_2.x
            y = asteroid_2.y
            loop do
              x -= x_delta
              y -= y_delta
              break if y < 0 || x < 0
              node = graph[x][y]
              asteroid_2.obscured_asteroids << node if node
            end

            loop do
              x += x_delta
              y += y_delta
              break if y < length - 1 || x > length - 1
              node = graph[x][y]
              asteroid_1.obscured_asteroids << node if node
            end
          else
            x_delta = asteroid_2.x - asteroid_1.x
            # asteroid_1 y will always be <= android_2 y due to the order of the arrays
            y_delta = asteroid_2.y - asteroid_1.y
            x = asteroid_2.x
            y = asteroid_2.y
            loop do
              x += x_delta
              y -= y_delta
              break if y < 0 || x < 0
              node = graph[x][y]
              asteroid_2.obscured_asteroids << node if node
            end

            loop do
              x -= x_delta
              y += y_delta
              break if y < length - 1 || x > length - 1
              node = graph[x][y]
              asteroid_1.obscured_asteroids << node if node
            end
          end
        end
      end
    end

    asteroids.map do |asteroid|
      asteroids.length - asteroid.obscured_asteroids.count - 1
    end#.max
  end
end
