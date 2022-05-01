class ChangeColumnName < ActiveRecord::Migration[6.0]
  def change
  	rename_column :titles, :likely_tournament, :valuable
  end
end
