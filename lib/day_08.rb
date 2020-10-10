class Day08
  def self.parse_image(width, height, image_data=parse_file)
    min_zeroes = width
    product = 0
    layers = image_data.split("").each_slice(width).each_slice(height).to_a
    layers.each do |layer|
      layer = layer.flatten
      count = layer.count("0")
      if count < min_zeroes
        min_zeroes = count
        product = layer.count("1") * layer.count("2")
      end
    end
    product
  end

  def self.parse_file
    File.readlines("config/day_08.txt")[0].strip
  end
end
