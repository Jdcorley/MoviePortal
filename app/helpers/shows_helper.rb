module ShowsHelper
  include HTTParty

  def self.popular_movies
    api_key = Rails.application.credentials.dig(:themoviedb, :api_key)
    HTTParty.get"https://api.themoviedb.org/3/discover/tv?api_key=#{api_key}&language=en-US&sort_by=popularity.desc&page=1&timezone=America%2FNew_York&include_null_first_air_dates=false"
  end

end
