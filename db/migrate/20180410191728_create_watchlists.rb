class CreateWatchlists < ActiveRecord::Migration[5.1]
  def change
    create_table :watchlists do |t|
      t.string :title
      t.integer :user_id
      t.integer :show_id
      t.timestamps
    end
  end
end
