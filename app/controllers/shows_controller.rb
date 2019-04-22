class ShowsController < ApplicationController
  include ShowsHelper
  layout "home"
  before_action :update_popular_shows

  def index
    if params[:search]
      @search_results_shows = Show.search_by_name(params[:search])
      respond_to do |format|
        format.js { render partial: 'shared/search-results' }
      end
    else
      @shows = Show.all
    end
  end

  def show
    if params[:search]
      @search_results_shows = Show.search_by_name(params[:search])
      respond_to do |format|
        format.js { render partial: 'shared/search-results' }
      end
    else
      @show = @shows.find(params[:id])
    end
  end

  private

  def show_params
    params.require(:show).permit(:name, :vote_average, :origin_country, :first_air_date, :overview, :poster_path)
  end

  def update_popular_shows
    @base_url = Show.base_url
    @shows = Show.all
    @popular_shows = Show.popular_shows
    @popular_shows.each do |show|
      next unless @shows.find_by(name: show["name"]).nil?
      Show.create(name: show["name"],
                  vote_average: show["vote_average"],
                  origin_country: show["origin_country"],
                  first_air_date: show["first_air_date"],
                  overview: show["overview"],
                  poster_path: show["poster_path"]).save!
    end
  end
end
