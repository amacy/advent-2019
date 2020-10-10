class Day08
  def self.verify_image(width, height, image_data=parse_file)
    min_zeroes = width
    product = 0
    layers(width, height, image_data).each do |layer|
      layer = layer.flatten
      count = layer.count("0")
      if count < min_zeroes
        min_zeroes = count
        product = layer.count("1") * layer.count("2")
      end
    end
    product
  end

  def self.decode_image(width, height, image_data=parse_file)
    result = []
    height.times { result << [] }

    layers(width, height, image_data).each do |layer|
      layer.each_with_index do |row, row_number|
        row.each_with_index do |pixel, column_number|
          if ["0", "1"].include?(pixel)
            result[row_number][column_number] ||= pixel
          end
        end
      end
    end

    result.map do |row|
      row.join.gsub("0", " ")
    end
  end

  def self.layers(width, height, image_data)
    image_data.split("").each_slice(width).each_slice(height).to_a
  end

  def self.parse_file
    File.readlines("config/day_08.txt")[0].strip
  end
end
