class AddUtcOffsetToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :utc_offset, :integer, default: 0
  end
end
