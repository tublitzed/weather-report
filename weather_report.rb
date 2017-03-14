require 'dotenv/load'
require 'optparse'
require 'httparty'
require './api'

DEFAULT_ZIP = 27713

options = {}
OptionParser.new do |opts|
  opts.on("-z ZIP", "Zip code") do |v|
    options[:zip] = v
  end
end.parse!

if !options[:zip]
  puts "\nAppend the -z flag to enter a zip code, ie `-z 11215` \nDefaulting to #{DEFAULT_ZIP}.\n"
end

class WeatherReport

  def initialize(zip)
    @zip = zip
    @api = API.new(zip, ENV['WEATHER_UNDERGROUND_API_KEY'])
    load_results
  end

  def load_results
    results = @api.get
    puts results
  end
end


WeatherReport.new(options[:zip] || DEFAULT_ZIP)
