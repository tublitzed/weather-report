require 'optparse'
require 'httparty'

DEFAULT_ZIP = 27713

options = {}
OptionParser.new do |opts|
  opts.on("-z", "--zip ZIP", "Zip code") do |v|
    options[:zip] = v
  end
end.parse!

class WeatherReport
  def initialize(zip)
    @zip = zip
    puts "\nReporting the weather for zip code: #{zip}..."
  end
end

if !options[:zip]
  puts "\nUse the -z, or --zip flag to enter a zip code.\nDefaulting to #{DEFAULT_ZIP}.\n"
end

report = WeatherReport.new(options[:zip] || DEFAULT_ZIP)
puts report

