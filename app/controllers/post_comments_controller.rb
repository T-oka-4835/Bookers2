class PostCommentsController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    comment = PostComment.new(post_comment_params)
    comment.user_id = current_user.id
    comment.book_id = book.id
    comment.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    post_comment = PostComment.find(params[:id])
    post_comment.destroy
    # PostComment.find_by(id: params[:id], book_id: params[:book_id].destroy)
    redirect_back(fallback_location: root_path )
  end

  private
  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
