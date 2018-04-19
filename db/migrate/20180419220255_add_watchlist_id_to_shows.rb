class AddWatchlistIdToShows < ActiveRecord::Migration[5.1]
  def change
    add_column :shows, :watchlist_id, :integer
  end
end
