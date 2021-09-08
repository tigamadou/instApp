class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :should_be_author, only: %i[edit update destroy]
  layout 'main', except: [:new, :edit]

  def index
    @posts = Post.all
    @style = 'default'
  end

  def show
    @posts = Post.all
    @favorite = current_user.favorites.find_by(post_id: @post.id)
  end

  def new
    if params[:back]
      @post = Post.new(post_params)
    else
      @post = Post.new
    end
  end

  def confirm
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    render :new if @post.invalid?
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    respond_to do |format|
      if @post.save
        UserMailer.user_mail(current_user, @post).deliver # #Addendum
        flash[:primary] = 'Post was primaryfully created.!'
        format.html { redirect_to @post }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        flash[:primary] = "Post was primaryfully updated."
        format.html { redirect_to @post }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      flash[:primary] = "Post deleted!."
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  private

  def should_be_author
    not_found if !helpers.author?(@post)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content, :image, :image_cache)
  end
end
