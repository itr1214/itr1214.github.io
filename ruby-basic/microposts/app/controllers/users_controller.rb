class UsersController < ApplicationController
   def show
      @user = User.find(params[:id])
      @microposts = @user.microposts.order(created_at: :desc)
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
    @followings_id = Relationship.where('follower_id = ?',params[:id])
     @idArray = []
     @count = 0
     @followings_id.each do |ids| 
        @idArray[@count] = [ids.followed_id]
        @count += 1
    end
     select_users(@idArray)
  end
 
  # フォロワーユーザー
  def followers
      @followers_id = Relationship.where('followed_id = ?',params[:id])
      @idArray = []
      @count = 0
      @followers_id .each do |ids|
        @idArray[@count] = [ids.follower_id]
        @count += 1
    end
      select_users(@idArray)
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
  def followering_id_select(object)
   
  end
end