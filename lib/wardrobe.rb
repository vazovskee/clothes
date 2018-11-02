require_relative 'file_reader'
require_relative 'clothing_item'

class Wardrobe
  def self.new_from_files(path_to_clothes_dir)
    clothes_info = FileReader.read_clothes_info(path_to_clothes_dir)
    new(clothes_info)
  end

  def initialize(clothes_info)
    clothing_items = clothes_info.map do |info|
      ClothingItem.new(
        item_name: info[:item_name],
        clothing_type: info[:clothing_type],
        temperature_range: info[:temperature_range]
      )
    end
    @clothing_items = organize_wardrobe(clothing_items)
  end

  def clothing_types
    @clothing_items.keys
  end

  def clothes_by_type(type)
    @clothing_items[type]
  end

  def clothes_set_for_current_weather(temperature)
    clothes_set = clothing_types.map do |type|
      appropriate_clothes = clothes_by_type(type).select do |clothes_item|
        clothes_item.fit_the_weather?(temperature)
      end
      appropriate_clothes.sample
    end
    clothes_set.compact
  end

  private

  def organize_wardrobe(clothing_items)
    organized_wardrobe = Hash.new { |hash, key| hash[key] = [] }
    clothing_items.each do |clothing_item|
      organized_wardrobe[clothing_item.clothing_type] << clothing_item
    end
    organized_wardrobe
  end
end
