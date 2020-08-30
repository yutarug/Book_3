class BooksController < ApplicationController
#before_action :authenticate_user!
before_action :authenticate_user!,:only => [:show, :index, :edit]

  def index
    @book = Book.new
    @user = User.find(current_user.id)
    @books = Book.all
  end
  def create
  	@book = Book.new(book_params)
    @book.user_id =  current_user.id
  	if @book.save
      flash[:notice] = "You have creatad book successfully"
  	redirect_to book_path(@book.id)
    else
    @books = Book.all
    #@book = Book.new
    @user = User.find(current_user.id)
    #flash.now[:alert] = "error"
    render :index
    end
  end

  def show
    @book = Book.new
  	@sa = Book.find(params[:id])
    @post_comment = PostComment.new
    # @user = User.find(@sa.user_id)
    @user = @sa.user
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user_id != current_user.id
    redirect_to books_path
   end
  end
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
    flash[:notice] = "You have updated book successfully"
    redirect_to book_path(@book.id)
    else
      #@book = Book.find(params[:id])
      #flash.now[:alert] = "error"
      render :edit
    end
  end
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end
  private
  def book_params
  	params.require(:book).permit(:title, :body, :user_id)
  end
end
