class RemoveComentIdFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :coment_id, :integer
  end
end
