class API
  attr_reader :api_key, :errors, :location, :zip

  BASE_URI = 'http://api.wunderground.com/api'

  def initialize(zip, api_key)
    @zip = zip
    @api_key = api_key
    @errors = []
    @location = load_location_data(zip)
  end

  def get
    url = build_url('conditions', [@location['state'], @location['city']])
    results = results_or_error(HTTParty.get(url))
    format_results(results)
  end

  private def results_or_error(results)
    unless results
      @errors.push(error)
      raise
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

  private def format_results(results)
    r = results['current_observation']
    formatted = "\n------------------------------------------------------------------------------\n"
    formatted << "Current weather conditions for #{r['display_location']['full']}:\n"
    formatted << "#{r['weather']}, with a temperature of #{r['temp_f']} degrees farenheight."
    if r['wind_mph'] > 0
      formatted << "\nThe wind is blowing at #{r['wind_mph']} mph."
    end
    formatted << "\nThe relative humidity is #{r['relative_humidity']}."
    formatted << "\n------------------------------------------------------------------------------\n"
    formatted << "\n#{r['observation_time']}\n\n"
    formatted
  end

  private def error
    "Unable to report results for zip: #{@zip}. Please make sure you are using a valid zip code and api key."
  end
end
