class PostCommentsController < ApplicationController
	def create
		book = Book.find(params[:book_id])
		comment = current_user.postComments.new(post_comment_params)
		comment.book_id = book.id
		redirect_to book_path(book.id)
	end

	def destroy
		@post_comment = PostComment.find(params[:book_id])
		if @post_comment.user != current_user
			redirect_to books_path
		end
		@post_comment.destroy
		book = Book.find(params[:book_id])
		redirect_to book_path(book.id)
	end

	private
	def post_comment_params
    	params.require(:post_comment).permit(:comment)
	end
end
