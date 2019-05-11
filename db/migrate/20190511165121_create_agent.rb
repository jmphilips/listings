class CreateAgent < ActiveRecord::Migration[5.1]
  def change
    create_table :agents do |t|
      t.string :email
      t.string :phone_number
      t.string :first_name
      t.string :last_name
    end
  end
end
