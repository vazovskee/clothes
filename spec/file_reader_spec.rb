require_relative '../lib/file_reader'

FIXTURES = File.join(__dir__, 'fixtures').freeze
ONE_CLOTHING_ITEM_DIR_PATH = File.join(FIXTURES, 'one_clothing_item')
SEVERAL_CLOTHES_DIR_PATH = File.join(FIXTURES, 'several_clothing_items')
EMPTY_DIR_PATH = File.join(FIXTURES, 'empty_dir')

RSpec.describe FileReader do
  describe '#read_clothes_info' do
    context 'when there is one file' do
      it 'returns one item' do
        clothes_info = FileReader.read_clothes_info(ONE_CLOTHING_ITEM_DIR_PATH)
        expect(clothes_info).to eq [{ item_name: 'Джинсы',
                                      clothing_type: 'Штаны',
                                      temperature_range: -5..15 }]
      end
    end

    context 'when there is several files' do
      it 'returns one several items' do
        clothes_info = FileReader.read_clothes_info(SEVERAL_CLOTHES_DIR_PATH)
        expect(clothes_info)
          .to eq [{ item_name: 'Кроссовки',
                    clothing_type: 'Обувь',
                    temperature_range: 0..15 },
                  { item_name: 'Зимняя куртка',
                    clothing_type: 'Верхняя одежда',
                    temperature_range: -35..-10 },
                  { item_name: 'Валенки',
                    clothing_type: 'Обувь',
                    temperature_range: -40..-10 },
                  { item_name: 'Джинсы',
                    clothing_type: 'Штаны',
                    temperature_range: -5..15 },
                  { item_name: 'Пальто',
                    clothing_type: 'Верхняя одежда',
                    temperature_range: -5..10 }]
      end
    end

    context 'when there is no files in dir' do
      it 'throws an error' do
        expect { FileReader.read_clothes_info(EMPTY_DIR_PATH) }
          .to raise_error(RuntimeError, 'Error: Empty clothes directory')
      end
    end
  end
end
