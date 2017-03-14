require_relative '../weather_report.rb'

class WeatherReportTest < Minitest::Test
  def test_initialize
    report = WeatherReport.new
    assert report.zip, 27713

    report2 = WeatherReport.new(11215)
    assert report2.zip, 11215
  end
end
