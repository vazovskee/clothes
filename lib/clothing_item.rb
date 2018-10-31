class ClothingItem
  attr_reader :item_name, :clothing_type, :temperature_range

  def initialize(item_name, clothing_type, temperature_range)
    @item_name = item_name
    @clothing_type = clothing_type
    @temperature_range = temperature_range
  end

  def fit_the_weather?(temperature)
    @temperature_range.include?(temperature)
  end

  def to_s
    "#{@item_name} (#{@clothing_type}) #{@temperature_range}"
  end
end
