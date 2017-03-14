class API
  BASE_URI = 'http://api.wunderground.com/api'

  def initialize(zip, api_key)
    @zip = zip
    @api_key = api_key
    @location = load_location_data(zip)

    puts "\nCurrent weather conditions for #{@location['city']}, #{@location['state']}...\n"
  end

  def get
    url = build_url('conditions', [@location['state'], @location['city']])
    results_or_error(HTTParty.get(url))
  end

  private def results_or_error(results)
    unless results
      puts error
      abort
    end
    results
  end

  private def build_url(path, params = [])
    "#{BASE_URI}/#{@api_key}/#{path}/q/#{params.join('/')}.json"
  end

  private def load_location_data(zip)
    url = build_url('geolookup', [zip])
    results_or_error(HTTParty.get(url)['location'])
  end

  private def error
    "*** ERROR! Unable to report results for zip: #{@zip}. Please make sure you are using a valid zip code."
  end
end
