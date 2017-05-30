class AddColumnToMicropost < ActiveRecord::Migration
  def change
    add_column :microposts, :retweet, :integer
  end
end
