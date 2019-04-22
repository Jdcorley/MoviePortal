module ShowsHelper

  def self.image_url_builder(base_url, poster_path, poster_size = 'w500')
    "#{base_url}#{poster_size}#{poster_path}".html_safe
  end

end

