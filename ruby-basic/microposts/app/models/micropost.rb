class Micropost < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  # validates :content, presence: true, length: { maximum: 140 }
  
  belongs_to :favorite_relationships, class_name: "Favorite",
                                      foreign_key: "micropost_id",
                                      dependent:   :destroy
  has_many :favorite_micropost, through: :favorite_relationships, source: :micropost
                                      
  
  # micro = Micropost.find(1)
  
  # micro.retweeted_user(micro.retweet).name
  
  # def retweet?
  #   retweet
  # end
  
  # def retweeted_user(id)
  #  @user = User.find(id)
  # end
end