require 'rails_helper'

RSpec.describe Show, type: :model do
  let(:movie_db_api_key) { Rails.application.credentials.dig(:themoviedb, :api_key) }
  let(:shows_response) { HTTParty.get("https://api.themoviedb.org/3/discover/tv?api_key=#{movie_db_api_key}&language=en-US&sort_by=popularity.desc&page=1&timezone=America%2FNew_York&include_null_first_air_dates=false") }
  let(:show_data_results) { shows_response["results"] }
  let(:no_show_name){ Show.new.save! }

  context '#popular_shows' do
    it 'queries popular tv show data' do
      expect(show_data_results).to be_an_instance_of(Array)
    end
  end

  context 'validates presence of show :name' do
    it 'raises error if show is commited without a :name' do
      expect{no_show_name}.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

end
