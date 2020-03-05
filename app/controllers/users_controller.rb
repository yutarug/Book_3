class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @book = Book.new
    @user = User.find(current_user.id)
  	@users = User.all
  end

  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books
  end
 def edit
  @book = Book.new
  @user = User.find(params[:id])
 end

 def update
  @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully"
    redirect_to user_path(@user.id)
    else 
      #@book = Book.find(params[:id])
      #@user = current_user

      #flash.now[:alert] = "error"
      render :edit
    end
 end

  private
  def user_params
  	params.require(:user).permit(:name , :introduction, :profile_image)
  end
end
