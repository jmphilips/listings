class CreateProperty < ActiveRecord::Migration[5.1]
  def change
    create_table :properties do |t|
      t.string :property_type
      t.string :address
      t.string :unit_number
      t.integer :price
      t.string :status
      t.string :description
      t.integer :bathroom_count
      t.integer :bedroom_count
      t.integer :square_feet
      t.integer :total_rooms
    end
  end
end
