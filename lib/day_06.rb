require "set"

class Day06
  def self.orbits(input=parse_file)
    result = 0
    counted_nodes = Set.new
    find_paths(input).each do |path|
      loop do
        node = path.shift
        if counted_nodes.include?(node)
          break
        else
          counted_nodes << node
          result += path.length
        end
      end
    end

    result
  end

  def self.distance_from_santa(input=parse_file)
    paths = find_paths(input).select do |path|
      ["SAN", "YOU"].include?(path[0])
    end

    result = 0
    paths[0].each_with_index do |node, index|
      if paths[1].include?(node)
        result = index + paths[1].index(node) - 2
        return result
      end
    end
  end

  def self.find_paths(input)
    child_to_parent = {}
    parent_to_children = {}
    input.each do |pair|
      parent, child = pair.split(")")
      child_to_parent[child] = parent
      parent_to_children[parent] ||= []
      parent_to_children[child] ||= []
      parent_to_children[parent] << child
    end

    ends = []
    parent_to_children.each do |parent, children|
      ends << parent if children.empty?
    end

    paths = []
    ends.each do |final_node|
      current_path = []
      current_node = final_node
      loop do
        if current_node.nil?
          paths << current_path.dup
          current_path = []
          break
        end
        current_path << current_node
        current_node = child_to_parent[current_node]
      end
    end
    paths
  end

  def self.parse_file
    File.readlines("config/day_06.txt").map(&:strip)
  end
end
