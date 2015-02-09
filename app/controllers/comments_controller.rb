class CommentsController < ApplicationController
  def create
    # in order to create a new comment, we need to find which post we are currently viewing
    @post = Post.find(params[:post_id])
    # a new comment is created for the specific post we found above
    @comment = @post.comments.create(comment_params)
    # after the comment is created, we redirect to show the post that the comment was created on
    redirect_to post_path(@post)
  end

  def destroy
    # find the ID of the post we want to destroy
    @post = Post.find(params[:post_id])
    # find the ID of the comment within the post that we want to find
    @comment = @post.comments.find(params[:id])
    # destroy the comment
    @comment.destroy
    # after the comment is destroyed, we redirect to show the post (the deleted comment has disappeared)
    redirect_to post_path(@post)
  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end