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
    @shows = Show.all
  end

  def new
    @show = Show.new
  end

  def create
    show = Show.create(show_params)
  end

  def edit
    @show = Show.find(params[:id])
  end

  def update
    @show = Show.find(params[:id])
    @show.update(show_params)
  end

  private

  def show_params
    params.require(:show).permit(:name)
  end
end
