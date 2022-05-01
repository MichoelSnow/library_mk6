class CreateEventTables < ActiveRecord::Migration[6.0]
    def change
      create_table :setups do |t|
        t.integer :game_id
        t.integer :event_id
  
        t.timestamps
      end
  
      create_table :teardowns do |t|
        t.integer :game_id
        t.integer :event_id
  
        t.timestamps
      end
    end
  end