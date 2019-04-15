class ShowsController < ApplicationController
  include ShowsHelper
  layout "home"
  before_action :save_shows

  def save_shows
    @popular_shows = ShowsHelper.popular_shows
    @shows = Show.all
    @popular_shows.each do |show|
      next unless @shows.find_by(name: show).nil?
        Show.create(name: show).save!
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
    @show = @shows.find(params[:id])
  end

  def new
    @show = Show.new
  end

  def create
    show = Show.create(show_params)
  end

  private

  def show_params
    params.require(:show).permit(:name)
  end
end
