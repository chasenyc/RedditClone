class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def show
    @comment = Comment.find(params[:id])
    @post = @comment.post
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to comment_url(@comment.top_level_parent)
    else
      render :new
    end
  end

  def destroy
  end

private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :parent_comment_id)
  end

end
