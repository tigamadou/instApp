class FavoritesController < ApplicationController
    
    def create
        favorite = current_user.favorites.create(post_id: params[:post_id])
        flash[:primary] = "#{favorite.post.user.name}'S blog has been added to favorites"
        redirect_to posts_path
    end

    def destroy
        favorite = current_user.favorites.find_by(id: params[:id]).destroy
        flash[:primary] = "#{favorite.post.user.name} Unblogged Mr.'s blog"
        redirect_to posts_path
    end

    def index
        @user = User.find(params[:profile_id])
        @style = 'tiles'
    end

end
