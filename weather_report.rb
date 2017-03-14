require 'dotenv/load'
require 'optparse'
require 'httparty'
require './api'

options = {}
OptionParser.new do |opts|
  opts.on("-z ZIP", "Zip code") do |v|
    options[:zip] = v
  end
end.parse!

if !options[:zip]
  puts "\nAppend the -z flag to enter a zip code, ie `-z 11215`\n"
end

class WeatherReport
  attr_reader :zip

  def initialize(zip = nil)
    @zip = zip ||= 27713
    @api = API.new(zip, ENV['WEATHER_UNDERGROUND_API_KEY'])
  end

  def conditions
    results = @api.get
    puts results
  end
end


report = WeatherReport.new(options[:zip])
puts report.conditions
