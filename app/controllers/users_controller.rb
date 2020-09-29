class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @book = @user.books 
  end

  def index
  end

  def edit
    @user = User.find(params[:id])
  end

end
