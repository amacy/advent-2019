class Day06
  def self.orbits(input)
    first_node = input.first.split(")").first

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
    current_path = []
    ends.each do |final_node|
      current_node = final_node
      loop do
        current_path << current_node
        if current_node == first_node
          paths << current_path.dup
          current_path = []
          break
        end
        current_node = child_to_parent[current_node]
      end
    end
    puts paths.inspect

    result = 0
    paths.each do |path|
      result += (1..path.length - 1).to_a.sum
    end

    result
  end
end
