class AddLicenseStateToAttendee < ActiveRecord::Migration[6.0]
  def change
    add_column :attendees, :id_state, :string, limit: 30
  end
end
