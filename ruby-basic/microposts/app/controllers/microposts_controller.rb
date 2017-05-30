class MicropostsController < ApplicationController
    before_action :logged_in_user, only: [:create]
    
    def create
        # a = params
        # binding.pry
        @microposts = current_user.microposts.build(micropost_params)
        if @microposts.save
            flash[:success] = "Micropost created!"
            redirect_to root_url
        else
            @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc) # この行を追加
            render 'static_params/home'
        end
    end
    
    def destroy
       @micropost = current_user.microposts.find_by(id: params[:id])
       return redirect_to root_url if @micropost.nil?
       @micropost.destroy
       flash[:success] = "Micropost deleted"
       redirect_to request.referrer || root_urlrail
    end
    
    # def uodate
        
    # end
    
    # def retweet
        
    #     retweet = micropost.build(micropost_id: micropost_params)
    #     # binding.pry
    # end
    
    private
    def micropost_params
        params.require(:micropost).permit(:content)
    end
    
#     def retweet_params()
#       params.permit(:micropost_id)
#   end
end
