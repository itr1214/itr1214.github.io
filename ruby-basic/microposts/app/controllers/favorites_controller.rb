class FavoritesController < ApplicationController
    
    def create
        # binding.pry
        micropost = Micropost.find(micropost_params[:id])
        like = current_user.favarites.build(micropost_id: micropost.id)
        
        @already = Favorite.find_by(user_id: current_user.id ,  micropost_id: micropost.id)
        if !@already
            like.save
            flash[:success] = "お気に入り登録をしました"            
        else
            Favorite.destroy(@already.id)
            flash[:danger] = "お気に入り登録を解除しました。"
        end
        
        #  current_user.favorite_users.new( user_id: current_user.id,
                                        # micropost_id: @micropost.id)
                                   
        redirect_to root_path
    end
    
    def like
        micropost = Micropost.find(params[:micropost_id])
        like = current_user.favarites.build(micropost_id: micropost.id)
        like.save
        redirect_to root_path
    end
      
    private
    def micropost_params
        
        params.require(:micropost).permit(:id)
    end
  
  
end
