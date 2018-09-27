class AddVoteToShow < ActiveRecord::Migration[5.1]
  def change
    add_column :shows, :vote, :string
  end
end
