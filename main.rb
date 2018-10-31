require_relative 'lib/clothing_item'
require_relative 'lib/wardrobe'

clothes_dir = File.join(Dir.pwd, 'data')

wardrobe = Wardrobe.new_from_files(clothes_dir)

puts 'Сколько градусов за окном? (можно с минусом)'
user_input = STDIN.gets.to_i

clothes_set = wardrobe.clothes_set_for_current_weather(user_input)

if clothes_set.empty?
  puts 'К сожалению, вам нечего надеть в такую погоду'
else
  puts 'Предлагаем сегодня надеть'
  clothes_set.each { |item| puts item }
end
