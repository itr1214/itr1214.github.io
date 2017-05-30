class AddMicropostToRelationship < ActiveRecord::Migration
  def change
    add_reference :relationships, :micropost, index: true, foreign_key: true
  end
end
