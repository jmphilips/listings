class PropertiesAgents < ActiveRecord::Migration[5.1]
  def change
    create_table :agents_properties, id: false do |t|
      t.belongs_to :property, index: true
      t.belongs_to :agent, index: true
    end
  end
end
