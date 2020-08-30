class UsersController < ApplicationController
  #before_action :authenticate_user!
  before_action :authenticate_user!,:only => [:show, :index, :edit]

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
   if @user.id != current_user.id
    redirect_to user_path(current_user.id)
   end
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
 def follows
  @user = User.find(params[:user_id])
 end
 def followers
  @user = User.find(params[:user_id])
 end

  private
  def user_params
  	params.require(:user).permit(:name , :introduction, :profile_image)
  end
end
