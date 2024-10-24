class AddGeocodingColumnToReview < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :address, :string, null: false, default: ""
    add_column :reviews, :latitude, :float, null: false, default: 0
    add_column :reviews, :longitude, :float, null: false, default: 0
  end
end
