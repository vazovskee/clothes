require 'rspec'
require 'clothing_item'

describe 'ClothingItem' do
  it 'assigns instance variables' do
    clothing_item = ClothingItem.new('Джинсы', 'Штаны', (-5..15))
    expect(clothing_item.item_name).to eq 'Джинсы'
    expect(clothing_item.clothing_type).to eq 'Штаны'
    expect(clothing_item.temperature_range).to eq (-5..15)
  end

  it '#fit_the_weather?' do
    clothing_item = ClothingItem.new('Джинсы', 'Штаны', (-5..15))
    [-5, -1, 0, 1, 5, 10, 15].each do |temperature|
      expect(clothing_item.fit_the_weather?(temperature)).to be_truthy
    end
    [-100, -30, -6, 16, 40, 90].each do |temperature|
      expect(clothing_item.fit_the_weather?(temperature)).to be_falsey
    end
  end

  it '#to_s' do
    clothing_item = ClothingItem.new('Джинсы', 'Штаны', (-5..15))
    correct_string = 'Джинсы (Штаны) -5..15'
    expect(clothing_item.to_s).to eq correct_string
  end
end
