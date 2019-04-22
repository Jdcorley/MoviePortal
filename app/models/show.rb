class Show < ApplicationRecord
  include HTTParty
  include PgSearch
  validates_presence_of :name
  pg_search_scope :search_by_name, :against => [:name],
                  using: { :tsearch => { :prefix => true } }

  $movie_db_api_key = Rails.application.credentials.dig(:themoviedb, :api_key)
  $show_data_response = HTTParty.get("https://api.themoviedb.org/3/discover/tv?api_key=#{$movie_db_api_key}&language=en-US&sort_by=popularity.desc&page=1&timezone=America%2FNew_York&include_null_first_air_dates=false")
  $image_data_response = HTTParty.get("https://api.themoviedb.org/3/configuration?api_key=#{$movie_db_api_key}")
  $show_attributes = $show_data_response['results']
  $image_attributes = $image_data_response['images']

  $attributes = {
      1 => 'name',
      2 => 'vote_average',
      3 => 'origin_country',
      4 => 'first_air_date',
      5 => 'overview',
      6 => 'poster_path'
  }.freeze

  def self.poster_image_sizes
    $image_attributes.select do |k, _v|
      k == 'poster_sizes'
    end
  end

  def self.base_url
    $image_attributes['base_url']
  end

  def self.popular_shows
    fix_countries(filter_attributes($show_attributes))
  end

  def self.filter_attributes(results)
    show_objects = []
    results.each do |show|
      show.select do |k, _v|
        $attributes.value?(k)
      end
      show_objects << show
    end
  end

  def self.fix_countries(show_objects)
    show_objects.each do |show|
      unless show['origin_country'].nil? || show['origin_country'].first.nil?
        show['origin_country'] = NormalizeCountry(show['origin_country'].first)
      end
    end
  end
end
