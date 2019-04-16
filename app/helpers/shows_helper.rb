module ShowsHelper
  include HTTParty

  $movie_db_api_key = Rails.application.credentials.dig(:themoviedb, :api_key)

  $attributes = {
      1 => "name",
      2 => "vote_average",
      3 => "origin_country",
      4 => "first_air_date",
      5 => "overview"
  }.freeze

  def self.popular_shows
    show_data = HTTParty.get(
        "https://api.themoviedb.org/3/discover/tv?api_key=#{$movie_db_api_key}&language=en-US&sort_by=popularity.desc&page=1&timezone=America%2FNew_York&include_null_first_air_dates=false"
    )["results"]
    filter_attributes(show_data)
  end

  def self.filter_attributes(results)
    show_objects = []
    results.each do |show|
      show.keep_if do |k, v|
        $attributes.has_value?(k)
      end
      show_objects << show
    end
    show_objects
  end

end
