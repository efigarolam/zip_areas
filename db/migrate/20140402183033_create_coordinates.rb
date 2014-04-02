class CreateCoordinates < ActiveRecord::Migration
  def change
    create_table :coordinates do |t|
      t.string :longitude
      t.string :latitude
      t.references :zipcode

      t.timestamps
    end
    add_index :coordinates, :zipcode_id
  end
end
