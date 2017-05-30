class AddColumnToUser < ActiveRecord::Migration
  def change
    add_column :users, :coment_id, :integer
  end
end
