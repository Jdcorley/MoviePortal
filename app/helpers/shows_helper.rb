module ShowsHelper
  include HTTParty
  $movie_db_api_key = Rails.application.credentials.dig(:themoviedb, :api_key)
  $show_data = HTTParty.get(
      "https://api.themoviedb.org/3/discover/tv?api_key=#{$movie_db_api_key}&language=en-US&sort_by=popularity.desc&page=1&timezone=America%2FNew_York&include_null_first_air_dates=false"
  )["results"]
  $attributes = {
      1 => "name",
      2 => "vote_average",
      3 => "origin_country",
      4 => "first_air_date",
      5 => "overview"
  }.freeze

  def self.popular_shows
    fix_countries(filter_attributes($show_data))
  end

  def self.filter_attributes(results)
    show_objects = Array.new
    results.each do |show|
      show.keep_if do |k, v|
        $attributes.has_value?(k)
      end
      show_objects << show
    end
  end

  def self.fix_countries(show_objects)
    show_objects.each do |show|
      unless show["origin_country"].nil? || show["origin_country"].first.nil?
        show["origin_country"] = NormalizeCountry(show["origin_country"].first)
      end
    end
  end

end
