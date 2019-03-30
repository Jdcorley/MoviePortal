module ShowsHelper
  include HTTParty

  def self.popular_movies
    api_key = Rails.application.credentials.dig(:themoviedb, :api_key)
    HTTParty.get"https://api.themoviedb.org/3/configuration?api_key=#{api_key}"
  end

end
