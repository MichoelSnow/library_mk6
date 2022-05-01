class AddSetupFieldsToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :setup_computer_tz, :timestamp, default: nil
    add_column :events, :setup_scan_games, :timestamp, default: nil
    add_column :events, :setup_add_new_games, :timestamp, default: nil
    add_column :events, :setup_library_server, :timestamp, default: nil
    add_column :events, :reset_setup, :timestamp, default: nil
  end
end
