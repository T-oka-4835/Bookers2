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
    # 検索機能
    @users = @users.where('name Like ?', "%#{params[:search]}%") if params[:search].present?
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'You have updated user successfully.'
    else
      render :edit
    end
  end

   def follow
    current_user.follow(params[:id])
    redirect_to root_path
   end

  def unfollow
    current_user.unfollow(params[:id])
    redirect_to root_path
  end

  # 検索機能
  def search
    @model = params["search"]["model"]
    @content = params["seach"]["content"]
    @how = params["search"]["how"]
    @dates = search_for(@how, @model, @content)
  end
  # 検索機能


private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

   # 検索機能
   def match(model, content)
     if model == 'user'
       User.where(name:content)
     elsif model == 'book'
       Book.where(title:content)
     end
   end

   def backward(model,content)
     if model == 'user'
       User.where("name LIKE?", "%#{content}")
     elsif model == 'book'
       Book.where("title LIKE", "%#{content}")
     end
   end

   def partical(model, content)
     if model == "user"
       User.where("name LIKE?", "%#{content}%")
     elsif model == "book"
       Book.where("title LIKE?", "%#{content}%")
     end
   end

   def search_for(how,model,content)
     case how
      when 'match'
        match(model,content)
      when 'forward'
        forward(model,content)
      when 'backward'
         backward(model,content)
      when 'partical'
         partical(model,content)
     end
   end

   # 検索機能
end
