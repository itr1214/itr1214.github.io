class UserlistController < ApplicationController
    def index
        @user_all = User.all
        @msg = 'test'
        
    end
    
end
