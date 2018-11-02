require_relative '../lib/wardrobe'

FIXTURES = File.join(__dir__, 'fixtures').freeze
ONE_CLOTHING_ITEM_DIR_PATH = File.join(FIXTURES, 'one_clothing_item')
SEVERAL_CLOTHES_DIR_PATH = File.join(FIXTURES, 'several_clothing_items')
EMPTY_DIR_PATH = File.join(FIXTURES, 'empty_dir')

RSpec.describe Wardrobe do
  let(:one_item_wardrobe) do
    Wardrobe.new_from_files(ONE_CLOTHING_ITEM_DIR_PATH)
  end
  let(:several_items_wardrobe) do
    Wardrobe.new_from_files(SEVERAL_CLOTHES_DIR_PATH)
  end

  describe '.new' do
    context 'initializing with no items' do
      it 'throws an error' do
        expect { Wardrobe.new_from_files(EMPTY_DIR_PATH) }
          .to raise_error(RuntimeError, 'Error: Empty clothes directory')
      end
    end
  end

  describe '#clothing_types' do
    context 'for one closing item' do
      it 'returns array with one clothing type' do
        expect(one_item_wardrobe.clothing_types).to eq ['Штаны']
      end
    end

    context 'for several closing items' do
      it 'returns array of clothing types' do
        expected_types = ['Обувь', 'Верхняя одежда', 'Штаны']
        expect(several_items_wardrobe.clothing_types).to eq expected_types
      end
    end
  end

  describe '#clothes_by_type' do
    context 'for one closing item' do
      context 'when there is chosen type' do
        it 'returns one clothing item of specified type' do
          clothes = one_item_wardrobe.clothes_by_type('Штаны').map(&:to_s)
          clothes_info = clothes.map(&:to_s)
          expect(clothes_info).to eq ['Джинсы (Штаны) -5..15']
        end
      end
      context 'when there is no chosen type' do
        it 'returns empty array' do
          clothes = one_item_wardrobe.clothes_by_type('Шляпа')
          expect(clothes).to eq []
        end
      end
    end

    context 'for several closing items' do
      context 'when there is chosen type' do
        it 'returns clothing items of specified type' do
          trousers = several_items_wardrobe.clothes_by_type('Штаны').map(&:to_s)
          trousers_info = trousers.map(&:to_s)
          expect(trousers_info).to eq ['Джинсы (Штаны) -5..15']

          shoes = several_items_wardrobe.clothes_by_type('Обувь').map(&:to_s)
          shoes_info = shoes.map(&:to_s)
          expect(shoes_info).to eq ['Кроссовки (Обувь) 0..15',
                                    'Валенки (Обувь) -40..-10']

          outerwear = several_items_wardrobe.clothes_by_type('Верхняя одежда')
                                            .map(&:to_s)
          outerwear_info = outerwear.map(&:to_s)
          expect(outerwear_info)
            .to eq ['Зимняя куртка (Верхняя одежда) -35..-10',
                    'Пальто (Верхняя одежда) -5..10']
        end
      end
      context 'when there is no chosen type' do
        it 'returns empty array' do
          clothes = one_item_wardrobe.clothes_by_type('Шляпа')
          expect(clothes).to eq []
        end
      end
    end
  end

  describe '#clothes_set_for_current_weather' do
    context 'for one closing item' do
      context 'when there is a suitable item' do
        it 'returns one suitable clothing item' do
          [-5, -1, 0, 1, 5, 10, 15].each do |temperature|
            clothes = one_item_wardrobe
                      .clothes_set_for_current_weather(temperature)
            clothes_info = clothes.map(&:to_s)
            expect(clothes_info).to eq ['Джинсы (Штаны) -5..15']
          end
        end
      end

      context 'when there is no suitable item' do
        it 'returns empty array' do
          [-100, -30, -6, 16, 40, 90].each do |temperature|
            clothes = one_item_wardrobe
                      .clothes_set_for_current_weather(temperature)
            expect(clothes).to eq []
          end
        end
      end
    end

    context 'for several closing items' do
      context 'when there is a suitable item' do
        it 'returns several suitable clothing items' do
          [-40, -38, -36].each do |temperature|
            clothes = several_items_wardrobe
                      .clothes_set_for_current_weather(temperature)
            clothes_info = clothes.map(&:to_s)
            expect(clothes_info).to eq ['Валенки (Обувь) -40..-10']
          end

          [-35, -21, -10].each do |temperature|
            clothes = several_items_wardrobe
                      .clothes_set_for_current_weather(temperature)
            clothes_info = clothes.map(&:to_s)
            expect(clothes_info).to eq ['Валенки (Обувь) -40..-10',
                                        'Зимняя куртка (Верхняя одежда) -35..-10']
          end

          [-5, -3, -1].each do |temperature|
            clothes = several_items_wardrobe
                      .clothes_set_for_current_weather(temperature)
            clothes_info = clothes.map(&:to_s)
            expect(clothes_info).to eq ['Пальто (Верхняя одежда) -5..10',
                                        'Джинсы (Штаны) -5..15']
          end

          [0, 5, 10].each do |temperature|
            clothes = several_items_wardrobe
                      .clothes_set_for_current_weather(temperature)
            clothes_info = clothes.map(&:to_s)
            expect(clothes_info).to eq ['Кроссовки (Обувь) 0..15',
                                        'Пальто (Верхняя одежда) -5..10',
                                        'Джинсы (Штаны) -5..15']
          end

          [11, 13, 15].each do |temperature|
            clothes = several_items_wardrobe
                      .clothes_set_for_current_weather(temperature)
            clothes_info = clothes.map(&:to_s)
            expect(clothes_info)
              .to eq ['Кроссовки (Обувь) 0..15',
                      'Джинсы (Штаны) -5..15']
          end
        end
      end

      context 'when there is no suitable item' do
        it 'returns empty array' do
          [-100, -70, -41, -9, -6, 16, 50, 90].each do |temperature|
            clothes = several_items_wardrobe
                      .clothes_set_for_current_weather(temperature)
            expect(clothes).to eq []
          end
        end
      end
    end
  end
end
