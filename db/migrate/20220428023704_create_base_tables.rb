class CreateBaseTables < ActiveRecord::Migration[6.0]
  def change
    create_table :attendees do |t|
      t.string :barcode, limit: 20
      t.string :first_name
      t.string :last_name
      t.boolean :volunteer, default: false
      t.string :handle
      t.integer :event_id

      t.timestamps
    end

    create_table :checkouts do |t|
      t.integer :game_id
      t.integer :attendee_id
      t.integer :event_id
      t.timestamp :check_out_time
      t.timestamp :return_time
      t.boolean :closed, default: false

      t.timestamps
    end

    create_table :events do |t|
      t.string :name
      t.string :location
      t.date :start_date
      t.date :end_date
      t.boolean :current, default: false
      t.timestamps
      t.integer :utc_offset
      t.timestamp :setup_computer_tz
      t.timestamp :setup_scan_games
      t.timestamp :setup_add_new_games
      t.timestamp :setup_library_server
      t.timestamp :reset_setup

      
    end

    create_table :games do |t|
      t.string :barcode, limit: 20
      t.integer :title_id
      t.boolean :culled, default: false
      t.integer :status

      t.timestamps
    end

    create_table :publishers do |t|
      t.string :name

      t.timestamps
    end

    create_table :titles do |t|
      t.string :title
      t.integer :publisher_id
      t.boolean :valuable, default: false

      t.timestamps
    end

    create_table :users do |t|
      t.string :user_name
      t.string :password_digest
      t.string :remember_token

      t.timestamps
    end

    User.create({ user_name: 'admin', password: 'tabletop', password_confirmation: 'tabletop' })
    User.create({ user_name: 'su', password: 'cloud9', password_confirmation: 'cloud9' })
  end
end
