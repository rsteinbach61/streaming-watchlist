class CreateShows < ActiveRecord::Migration[5.1]
  def change
    create_table :shows do |t|
      t.string  :show_title
      

      t.timestamps
    end
  end
end
