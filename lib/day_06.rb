require "set"

class Day06
  def self.orbits(input=parse_file)
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

    result = 0
    counted_nodes = Set.new
    paths.each do |path|
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

  def self.parse_file
    File.readlines("config/day_06.txt").map(&:strip)
  end
end
