class CreateShows < ActiveRecord::Migration[5.2]
  def change
    create_table :shows do |t|
      t.string :name
      t.float :vote_average
      t.string :origin_country
      t.date :first_air_date
      t.string :overview
      t.timestamps
    end
  end
end
