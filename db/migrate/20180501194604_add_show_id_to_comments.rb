class AddShowIdToComments < ActiveRecord::Migration[5.1]
  def change
    add_column :comments, :show_id, :integer
  end
end
