class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    render :new
  end
  
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to post_url(@comment.post_id)
    else
      flash.now[:errors] = @comment.errors.full_messages
      redirect_to post_url(@comment.post_id)
    end
  end
  
  def index
    @comments = Comment.where(parent_id: nil)
    render :index
  end
  
  private
  def comment_params
    params.require(:comment).permit(:content)
  end
  
end
