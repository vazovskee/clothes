require 'open-uri'
require 'nokogiri'
require 'json'

URL = 'https://www.gismeteo.ru/'.freeze

module GismeteoParser
  def self.parse_weather(path_to_output_json)
    begin
      html = URI.parse(URL).open
    rescue SocketError
      raise 'Error: unable to connect to Gismeteo'
    end

    page = Nokogiri::HTML(html)

    current_temperature = page.css('.js_meas_container.temperature').text.strip
    user_city = page.css('.link.blue.weather_current_link.no_border').text.strip
    current_time = Time.now

    weather_info = { city: user_city,
                     temperature: current_temperature.tr(',', '.'),
                     time: current_time }

    File.write(path_to_output_json, JSON.pretty_generate(weather_info))
  end
end
