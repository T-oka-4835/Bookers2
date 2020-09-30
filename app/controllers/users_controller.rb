class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end

  def index
    @book = Book.new
    @user = current_user
  end

  def edit
    @user = User.find(params[:id])
  end

private
  def user_params
    params.require(:user).permit(:profile_image)
  end

end
