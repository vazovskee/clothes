require 'time'
require 'json'

module JsonReader
  def self.read_weather(path_to_json)
    begin
      json_file = File.read(path_to_json, encoding: 'UTF-8')
    rescue SystemCallError
      raise 'Error: json-file with weather was not found'
    end

    weather_info = JSON.parse(json_file)

    {
      city: weather_info['city'],
      temperature: weather_info['temperature'].to_f,
      time: Time.parse(weather_info['time'])
    }
  end
end
