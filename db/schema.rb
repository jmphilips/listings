# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_190_511_165_154) do
  create_table 'agents', force: :cascade do |t|
    t.string 'email'
    t.string 'phone_number'
    t.string 'first_name'
    t.string 'last_name'
  end

  create_table 'agents_properties', id: false, force: :cascade do |t|
    t.integer 'property_id'
    t.integer 'agent_id'
    t.index ['agent_id'], name: 'index_agents_properties_on_agent_id'
    t.index ['property_id'], name: 'index_agents_properties_on_property_id'
  end

  create_table 'properties', force: :cascade do |t|
    t.string 'property_type'
    t.string 'address'
    t.string 'unit_number'
    t.integer 'price'
    t.string 'status'
    t.string 'description'
    t.integer 'bathroom_count'
    t.integer 'bedroom_count'
    t.integer 'square_feet'
    t.integer 'total_rooms'
  end
end
