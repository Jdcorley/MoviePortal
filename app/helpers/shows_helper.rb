module ShowsHelper
  include HTTParty
  $movie_db_api_key = Rails.application.credentials.dig(:themoviedb, :api_key)

  def self.popular_shows
    show_data = HTTParty.get(
        "https://api.themoviedb.org/3/discover/tv?api_key=#{$movie_db_api_key}&language=en-US&sort_by=popularity.desc&page=1&timezone=America%2FNew_York&include_null_first_air_dates=false"
    )["results"]
    by_name(show_data)
  end

  def self.by_name(results)
    results.map { |result| result["name"] }
  end

end
