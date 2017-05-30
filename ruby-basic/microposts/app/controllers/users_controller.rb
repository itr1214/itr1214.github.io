class UsersController < ApplicationController
   
   def show
      @user = User.find(params[:id])
      @retweet =  current_user.tweet_items
    #   binding.pry
      
      @microposts = @user.microposts.order(created_at: :desc)
    #   @microposts =  tweet + @retweet
    #   binding.pry
      
    #   @microposts.push(@retweet)
      
    #   @microposts.each do |retweet|
    #      @microposts = @user.microposts.where(retweet: nil)
    #   end
    
    # @retweet_user.each do |f|
    #     #リツイートされている場合
    #     if !f.retweet.nil?
    #         @retweet = Micropost.find(f.retweet)
    #         # binding.pry
            
    #     end
    # end
    
    
    #   binding.pry
    #   @microposts += @user.microposts.where(retweet: @microposts["retweet"].to_i)
      
      
   end
   
   def new
        @user = User.new
   end
   
   def create
       @user = User.new(user_params)
      if @user.save
         flash[:success] = "Welcome to the Sample App!"
         redirect_to @user
      else
         render 'new'
      end
   end
   
   def update
      @user = User.find(params[:id])
      if @user.update(update_params)
         flash[:success] = "更新完了"
         redirect_to @user
      else
         flash[:danger] = "更新に失敗しました。"
         render 'show'
      end
   end
   
    #フォローユーザー
  def followings
    @followings_users = current_user.following_users
  end
 
  # フォロワーユーザー
  def followers
      @followers_users =  current_user.followers_users
    #   binding.pry
  end
  
  def favorite
    @like = favarite_microposts
    @like = current_user.favorite_user
  end
  
  def retweet
      content = current_user.retweet_user(retweet_params["micropost_id"])
     retweet = current_user.microposts.build(content: content["content"] ,retweet: retweet_params["micropost_id"])
    #  binding.pry
     
     # リツイートされているか確認
     if current_user.retweet_conf(retweet_params["micropost_id"]).empty?
        retweet.save
        flash[:success] = "retweetしました。"
    else
        Micropost.delete_all(user_id: current_user.id, retweet: retweet_params["micropost_id"])
        flash[:danger] = "retweet解除しました。"
     end
    #  binding.pryex
     redirect_to root_path
  end
   
  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
  
  def update_params
      params.require(:user).permit(:name, :email, :region, :hitokoto, :password,
                                 :password_confirmation)
  end
  def select_users(ids)
      @followings_users = User.find(ids)
  end
  def retweet_params
      params.permit(:micropost_id)
  end

end