class AddShowTypeToShows < ActiveRecord::Migration[5.1]
  def change
    rename_column :shows, :type, :show_type
  end
end
