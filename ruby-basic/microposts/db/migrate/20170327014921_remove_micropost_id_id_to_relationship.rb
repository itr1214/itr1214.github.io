class RemoveMicropostIdIdToRelationship < ActiveRecord::Migration
  def change
    remove_column :relationships, :micropost_id_id, :string
  end
end
