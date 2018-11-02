require_relative 'lib/clothing_item'
require_relative 'lib/wardrobe'
require_relative 'lib/gismeteo_parser'
require_relative 'lib/json_reader'

GISMETEO_JSON = File.join(__dir__, 'data', 'gismeteo.json').freeze
CLOTHES_DIR = File.join(__dir__, 'data', 'clothes')
UPDATES_FREQUENCY = 7200 # 2 hours

weather_info = JsonReader.read_weather(GISMETEO_JSON)
last_parsing_time = weather_info[:time]

# updating info if it's out of date
if (Time.now - last_parsing_time) > UPDATES_FREQUENCY
  puts 'Собираются данные о текущей температуре в Вашем городе с gismeteo.ru'
  GismeteoParser.parse_weather(GISMETEO_JSON)
  weather_info = JsonReader.read_weather(GISMETEO_JSON)
end

user_city = weather_info[:city]
current_temperature = weather_info[:temperature]

puts "Текущая температура в городе #{user_city} " \
      "составляет #{current_temperature}°C"
puts

wardrobe = Wardrobe.new_from_files(CLOTHES_DIR)

clothes_set = wardrobe.clothes_set_for_current_weather(current_temperature)

if clothes_set.empty?
  puts 'К сожалению, вам нечего надеть в такую погоду'
else
  puts 'Предлагаем сегодня надеть:'
  clothes_set.each { |item| puts item }
end
