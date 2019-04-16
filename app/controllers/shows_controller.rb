class ShowsController < ApplicationController
  include ShowsHelper
  layout "home"
  before_action :save_shows

  def save_shows
    @shows = Show.all
    @popular_shows = ShowsHelper.popular_shows
    @popular_shows.each do |show|
      next unless @shows.find_by(name: show["name"]).nil?
        Show.create(name: show["name"],
                    vote_average: show["vote_average"],
                    origin_country: show["origin_country"],
                    first_air_date: show["first_air_date"],
                    overview: show["overview"]
        ).save!
    end
  end

  def index
    if params[:search]
      @search_results_shows = Show.search_by_name(params[:search])
      respond_to do |format|
        format.js { render partial: 'search-results'}
      end
    else
      @shows = Show.all
    end
  end

  def show
    if params[:search]
      @search_results_shows = Show.search_by_name(params[:search])
      respond_to do |format|
        format.js { render partial: 'search-results'}
      end
    else
      @show = @shows.find(params[:id])
    end
  end

  def new
    @show = Show.new
  end

  def create
    show = Show.create(show_params)
  end

  private

  def show_params
    params.require(:show).permit(:name, :vote_average, :origin_country, :first_air_date, :overview)
  end
end
