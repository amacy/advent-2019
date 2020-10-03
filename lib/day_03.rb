class Day03
  def self.wire_distance(path_1=parse_file[0], path_2=parse_file[1])
    nodes_1 = to_nodes(path_1)
    nodes_2 = to_nodes(path_2)
    intersections = nodes_1 & nodes_2
    intersections.map do |intersection|
      intersection.map(&:abs).inject(&:+)
    end.min
  end

  def self.to_nodes(path)
    current_x = 0
    current_y = 0
    nodes = []
    path.map do |location|
      distance = location[1..-1].to_i
      case location[0]
      when "U"
        travel_range(current_y + 1, distance).each do |y|
          nodes << [current_x, y]
        end

        current_y += distance
      when "D"
        travel_range(current_y - 1, -distance).each do |y|
          nodes << [current_x, y]
        end

        current_y -= distance
      when "R"
        travel_range(current_x + 1, distance).each do |x|
          nodes << [x, current_y]
        end

        current_x += distance
      when "L"
        travel_range(current_x - 1, -distance).each do |x|
          nodes << [x, current_y]
        end

        current_x -= distance
      end
    end
    nodes
  end

  def self.travel_range(start, distance)
    if distance < 0
      (start + distance..start).to_a.reverse
    else
      start..start + distance
    end
  end

  def self.parse_file
    File.readlines("config/day_03.txt").map do |line|
      line.split(",")
    end
  end
end
