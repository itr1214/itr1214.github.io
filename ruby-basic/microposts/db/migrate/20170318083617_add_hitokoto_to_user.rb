class AddHitokotoToUser < ActiveRecord::Migration
  def change
    add_column :users, :hitokoto, :string
  end
end
