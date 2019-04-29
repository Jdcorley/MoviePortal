require 'rails_helper'

RSpec.describe ShowsController, type: :controller do
  let(:valid_show) { Show.create!(name: "Game of Thrones")}
  let(:invalid_show) { Show.create! }

  describe 'GET #index' do
    it 'has a 200 status code' do
      get :index
      expect(response.status).to eq(200)
    end
    it 'renders shows/index view' do
      get :index
      expect(response).to render_template('shows/index')
    end
  end

  describe '#show_params' do
    it 'requires a valid show name' do
      expect{invalid_show}.to raise_error(ActiveRecord::RecordInvalid)
      expect{valid_show}.not_to raise_error(ActiveRecord::RecordInvalid)
    end
  end

end
