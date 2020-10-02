class UsersController < ApplicationController

before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end

  def index
    @book = Book.new
    @user = current_user
    # 他のユーザー
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    user.update(user_params)
    redirect_to user_path(user), notice: 'You have updated user successfully.'
  end

private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

end
