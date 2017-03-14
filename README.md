# weather-report
Generate a weather report using the [WUnderground API](https://www.wunderground.com).

## Installation:

- `gem install dotenv`
- `cp .env.example .env`
- get an API key from Rachel, or use your own. Replace the `WEATHER_UNDERGROUND_API_KEY` value in `.env` with this key.

## Usage:

- `ruby weather_report.rb`
- OR: `ruby weather_report.rb -z 11215` - Optionally specific a zip code using the `-z` flag.

## Tests:

- `ruby tests/_test_suite.rb`
