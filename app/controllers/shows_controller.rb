class ShowsController < ApplicationController
  include ShowsHelper

  def home
    @popular_movies = ShowsHelper.popular_movies
  end
end
