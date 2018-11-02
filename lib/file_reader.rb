module FileReader
  def self.read_clothes_info(path_to_clothes)
    clothes_paths = Dir["#{path_to_clothes}/*.txt"]

    raise 'Error: Empty clothes directory' if clothes_paths == []

    clothes_paths.map do |file_path|
      lines = File.readlines(file_path, encoding: 'UTF-8').map(&:chomp)

      item_name = lines[0]
      clothing_type = lines[1]
      left_limit, right_limit = lines[2].delete('()').split(', ')
      temperature_range = Range.new(left_limit.to_i, right_limit.to_i)

      { item_name: item_name,
        clothing_type: clothing_type,
        temperature_range: temperature_range }
    end
  end
end
