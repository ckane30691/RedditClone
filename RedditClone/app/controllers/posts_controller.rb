class PostsController < ApplicationController
  before_action :require_logged_in, except: [:show]

  def new
    @post = Post.new
    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    @post.sub_id = params[:sub_id]
    if @post.save
      redirect_to sub_post_url(@post.sub_id, @post.id)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
    render :edit
  end

  def show
    @post = Post.find_by(id: params[:id])
    render :show
  end

  def update
    @post = Post.find_by(id: params[:id])
    if @post && @post.author_id == current_user.id
      if @post.update_attributes(post_params)
        redirect_to sub_post_url(@post.sub_id, @post.id)
      else
        flash.now[:errors] = @post.errors.full_messages
        render :edit
      end
    else
      flash.now[:errors] = ["You are not the author of this post"]
      render :edit
    end
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content)
  end
end
