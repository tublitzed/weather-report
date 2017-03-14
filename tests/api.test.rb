require_relative '../api.rb'

class APITest < Minitest::Test
  def test_initialize
    api = API.new(97405, ENV['WEATHER_UNDERGROUND_API_KEY'])
    assert 97405, api.zip
    assert ENV['WEATHER_UNDERGROUND_API_KEY'], api.api_key
    assert 'OR', api.location['state']
    assert 'Eugene', api.location['city']
  end

  def test_initialize_with_invalid_api_key
    assert RuntimeError do
      API.new(97405, 'some-fake-key')
    end
  end
end
