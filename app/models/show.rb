class Show < ApplicationRecord
  validates_presence_of :name
  include PgSearch
  pg_search_scope :search_by_name, :against => [:name],
                  using: {
                      :tsearch => {:prefix => true}
                  }
end
