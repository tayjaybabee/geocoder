class GeocoderMaxmindGeoliteCity < ActiveRecord::Migration
  def change
    create_table :maxmind_geolite_city_blocks, id: false do |t|
      t.column :startIpNum, 'integer unsigned', null: false
      t.column :endIpNum, 'integer unsigned', null: false
      t.column :locId, 'integer unsigned', null: false
    end
    add_index :maxmind_geolite_city_blocks, :startIpNum, unique: true

    create_table :maxmind_geolite_city_location, id: false do |t|
  	  t.column :locId, 'integer unsigned', null: false
      t.string :country, null: false
      t.string :region, null: false
      t.string :city
      t.string :postalCode, null: false
      t.float :latitude
      t.float :longitude
      t.integer :metroCode
      t.integer :areaCode
    end
    add_index :maxmind_geolite_city_location, :locId, unique: true
  end
end