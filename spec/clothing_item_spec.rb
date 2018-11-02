require_relative '../lib/clothing_item'

RSpec.describe ClothingItem do
  let(:clothing_item) do
    ClothingItem.new(
      item_name: 'Джинсы',
      clothing_type: 'Штаны',
      temperature_range: (-5..15)
    )
  end

  describe '#item_name' do
    it 'returns item_name' do
      expect(clothing_item.item_name).to eq 'Джинсы'
    end
  end

  describe '#clothing_type' do
    it 'returns clothing_type' do
      expect(clothing_item.clothing_type).to eq 'Штаны'
    end
  end

  describe '#temperature_range' do
    it 'returns temperature_range' do
      expect(clothing_item.temperature_range).to eq (-5..15)
    end
  end

  describe '#fit_the_weather?' do
    context 'when temperature is suitable' do
      it 'returns true' do
        [-5, -1, 0, 1, 5, 10, 15].each do |temperature|
          expect(clothing_item.fit_the_weather?(temperature)).to be_truthy
        end
      end
    end

    context 'when temperature is unsuitable' do
      it 'return false' do
        [-100, -30, -6, 16, 40, 90].each do |temperature|
          expect(clothing_item.fit_the_weather?(temperature)).to be_falsey
        end
      end
    end
  end

  describe '#to_s' do
    it 'returns string with clothing item info' do
      correct_string = 'Джинсы (Штаны) -5..15'
      expect(clothing_item.to_s).to eq correct_string
    end
  end
end
