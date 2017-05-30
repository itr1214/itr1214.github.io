class User < ActiveRecord::Base
    before_save {self.email = self.email.downcase}
    validates :name, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
      validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
    validates :region,  length: { maximum: 20 }
    has_secure_password
    has_many :microposts, class_name: "Micropost"
    
    has_many :following_relationships, class_name:  "Relationship",
                                       foreign_key: "follower_id",
                                       dependent:   :destroy
                                       
    has_many :following_users, through: :following_relationships, source: :followed
    
    has_many :followers_relationships, class_name:  "Relationship",
                                       foreign_key: "followed_id",
                                       dependent:   :destroy
                                       
    has_many :followers_users, through: :followers_relationships, source: :follower
    
    has_many :favarites, class_name:  "Favorite",
                         foreign_key: "user_id",
                         dependent:   :destroy
                         
    has_many :favarite_microposts, through: :favarites, source: :micropost
                         
#   def favorite_user(other_user)
#       favorite_relationships.find_or_create_by(user_id: other_user.id)
#   end
  
  
     #他のユーザをフォローする
  def follow(other_user)
     following_relationships.find_or_create_by(followed_id: other_user.id)
  end
  # フォローしているユーザーをアンフォローする
  def unfollow(other_user)
     following_relationship = following_relationships.find_by(followed_id: other_user.id)
     following_relationship.destroy if following_relationship
  end
  
  # あるユーザーをフォローしているかどうか？
  def following?(other_user)
     following_users.include?(other_user)
  end
  
  def feed_items
     Micropost.where(user_id: following_user_ids + [self.id], retweet: nil)
  end
  
  def tweet_items()
     ids = microposts.where.not(retweet: nil).pluck(:retweet)
     Micropost.find(ids)
    #  Micropost.where.or(id: ids)
    #  binding.pry
     
  end
  def like_micropost(id)
     Favorite.where(micropost_id: id)
  end
  def retweet_conf(micropost_id)
      Micropost.where(retweet: micropost_id)
  end
  
  def retweet_user(micropost_id)
      Micropost.find(micropost_id)
  end
      
  
  
  
  
  def favorite_user(other_user)
    # favs = []
    # favarits = other_user.favarites
    # favarits.each do |fav|                                                                                                                                                    
    #     microppos = fav.micropost
    #     favs.append(microppos)    
    # end  
      Micropost.where(id: favarites.pluck(:micropost_id))
  end
  
end