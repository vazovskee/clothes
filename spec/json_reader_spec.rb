require_relative '../lib/json_reader'
require 'rspec'

FIXTURES = File.join(__dir__, 'fixtures').freeze
JSON_PATH = File.join(FIXTURES, 'test_jsons', 'json_reader_test.json')
WRONG_PATH = ''.freeze

RSpec.describe JsonReader do
  describe '.read_weather' do
    context 'when when there is correct path' do
      it 'returns hash with weather info' do
        puts JSON_PATH
        weather_info = JsonReader.read_weather(JSON_PATH)
        expect(weather_info).to eq ({
          city: 'Вавилон',
          temperature: -15.7,
          time: Time.new(2475, 07, 10, 14, 27, 19, '+08:00')
        })
      end
    end

    context 'when when there is wrong path' do
      it 'throws an error' do
        expect { JsonReader.read_weather(EMPTY_DIR_PATH) }
          .to raise_error(RuntimeError,
                          'Error: json-file with weather was not found')
      end
    end
  end
end
