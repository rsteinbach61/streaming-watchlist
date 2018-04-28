class RemoveShowIdFromWatchists < ActiveRecord::Migration[5.1]
  def change
    remove_column :watchlists, :show_id
  end
end
