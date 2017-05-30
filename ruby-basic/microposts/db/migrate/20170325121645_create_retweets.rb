class CreateRetweets < ActiveRecord::Migration
  def change
    create_table :retweets do |t|
      t.references :user_id, index: true, foreign_key: true
      t.references :micropost_id, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
