require 'rspec'
require 'file_reader'

FIXTURES = File.join(Dir.pwd, 'spec', 'fixtures').freeze

describe 'FileReader' do
  it 'reads one clothes info' do
    clothes_dir_path = File.join(FIXTURES, 'one_clothing_item')
    clothes_info = FileReader.read_clothes_info(clothes_dir_path)
    expect(clothes_info).to eq [['Джинсы', 'Штаны', -5..15]]
  end

  it 'reads several clothes info' do
    clothes_dir_path = File.join(FIXTURES, 'several_clothing_items')
    clothes_info = FileReader.read_clothes_info(clothes_dir_path)
    expect(clothes_info).to eq [['Кроссовки', 'Обувь', 0..15],
                                ['Зимняя куртка', 'Верхняя одежда', -35..-10],
                                ['Валенки', 'Обувь', -40..-10],
                                ['Джинсы', 'Штаны', -5..15],
                                ['Пальто', 'Верхняя одежда', -5..10]]
  end

  it 'reads from empty dir' do
    empty_dir = File.join(FIXTURES, 'empty_dir')
    expect { FileReader.read_clothes_info(empty_dir) }
      .to raise_error(RuntimeError, 'Empty clothes directory')
  end
end
