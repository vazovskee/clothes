require 'rspec'
require 'wardrobe'

FIXTURES = File.join(Dir.pwd, 'spec', 'fixtures').freeze

describe 'Wardrobe' do
  it '#clothing_types for one closing item' do
    clothes_dir_path = File.join(FIXTURES, 'one_clothing_item')
    wardrobe = Wardrobe.new_from_files(clothes_dir_path)
    expect(wardrobe.clothing_types).to eq ['Штаны']
  end

  it '#clothes_by_type for one closing item' do
    clothes_dir_path = File.join(FIXTURES, 'one_clothing_item')
    wardrobe = Wardrobe.new_from_files(clothes_dir_path)

    clothes = wardrobe.clothes_by_type('Штаны').map(&:to_s)
    clothes_info = clothes.map(&:to_s)
    expect(clothes_info)
      .to eq ['Джинсы (Штаны) -5..15']
  end

  it '#clothes_set_for_current_weather for one closing item' do
    clothes_dir_path = File.join(FIXTURES, 'one_clothing_item')
    wardrobe = Wardrobe.new_from_files(clothes_dir_path)

    [-5, -1, 0, 1, 5, 10, 15].each do |temperature|
      clothes = wardrobe.clothes_set_for_current_weather(temperature)
      clothes_info = clothes.map(&:to_s)
      expect(clothes_info)
        .to eq ['Джинсы (Штаны) -5..15']
    end

    [-100, -30, -6, 16, 40, 90].each do |temperature|
      expect(wardrobe.clothes_set_for_current_weather(temperature))
        .to eq []
    end
  end

  it '#clothing_types for several closing items' do
    clothes_dir_path = File.join(FIXTURES, 'several_clothing_items')
    wardrobe = Wardrobe.new_from_files(clothes_dir_path)
    expect(wardrobe.clothing_types).to eq ['Обувь',
                                           'Верхняя одежда',
                                           'Штаны']
  end

  it '#clothes_by_type for several closing items' do
    clothes_dir_path = File.join(FIXTURES, 'several_clothing_items')
    wardrobe = Wardrobe.new_from_files(clothes_dir_path)

    trousers = wardrobe.clothes_by_type('Штаны').map(&:to_s)
    trousers_info = trousers.map(&:to_s)
    expect(trousers_info)
      .to eq ['Джинсы (Штаны) -5..15']

    shoes = wardrobe.clothes_by_type('Обувь').map(&:to_s)
    shoes_info = shoes.map(&:to_s)
    expect(shoes_info)
      .to eq ['Кроссовки (Обувь) 0..15',
              'Валенки (Обувь) -40..-10']

    outerwear = wardrobe.clothes_by_type('Верхняя одежда').map(&:to_s)
    outerwear_info = outerwear.map(&:to_s)
    expect(outerwear_info)
      .to eq ['Зимняя куртка (Верхняя одежда) -35..-10',
              'Пальто (Верхняя одежда) -5..10']
  end

  it '#clothes_set_for_current_weather for one closing item' do
    clothes_dir_path = File.join(FIXTURES, 'several_clothing_items')
    wardrobe = Wardrobe.new_from_files(clothes_dir_path)

    [-40, -38, -36].each do |temperature|
      clothes = wardrobe.clothes_set_for_current_weather(temperature)
      clothes_info = clothes.map(&:to_s)
      expect(clothes_info)
        .to eq ['Валенки (Обувь) -40..-10']
    end

    [-35, -21, -10].each do |temperature|
      clothes = wardrobe.clothes_set_for_current_weather(temperature)
      clothes_info = clothes.map(&:to_s)
      expect(clothes_info)
        .to eq ['Валенки (Обувь) -40..-10',
                'Зимняя куртка (Верхняя одежда) -35..-10']
    end

    [-5, -3, -1].each do |temperature|
      clothes = wardrobe.clothes_set_for_current_weather(temperature)
      clothes_info = clothes.map(&:to_s)
      expect(clothes_info)
        .to eq ['Пальто (Верхняя одежда) -5..10',
                'Джинсы (Штаны) -5..15']
    end

    [0, 5, 10].each do |temperature|
      clothes = wardrobe.clothes_set_for_current_weather(temperature)
      clothes_info = clothes.map(&:to_s)
      expect(clothes_info)
        .to eq ['Кроссовки (Обувь) 0..15',
                'Пальто (Верхняя одежда) -5..10',
                'Джинсы (Штаны) -5..15']
    end

    [11, 13, 15].each do |temperature|
      clothes = wardrobe.clothes_set_for_current_weather(temperature)
      clothes_info = clothes.map(&:to_s)
      expect(clothes_info)
        .to eq ['Кроссовки (Обувь) 0..15',
                'Джинсы (Штаны) -5..15']
    end

    [-100, -70, -41, -9, -6, 16, 50, 90].each do |temperature|
      expect(wardrobe.clothes_set_for_current_weather(temperature))
        .to eq []
    end
  end

  it 'tries to initialize collection with no items' do
    empty_dir = File.join(FIXTURES, 'empty_dir')
    expect { Wardrobe.new_from_files(empty_dir) }
      .to raise_error(RuntimeError, 'Empty clothes directory')
  end
end
