class PostsController < ApplicationController

  before_action :user_is_author, only: [:edit, :update]
  before_action :user_is_authorized, only: [:destroy]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_url(@post)
    else
      render :new
    end
  end

  def edit
    @post ||= Post.find(params[:id])
  end

  def show
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    if @post.save
      redirect_to post_url(@post)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to subs_url
  end

  def user_is_author
    @post = Post.find(params[:id])
    unless current_user.id == @post.user_id
      redirect_to subs_url
    end
  end

  def user_is_authorized
    @post = Post.find(params[:id])
    unless current_user.id == @post.user_id ||
           current_user.id == @post.sub.moderator.id
      redirect_to post_url(@post.id)
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :url, sub_ids: [])
  end

end
