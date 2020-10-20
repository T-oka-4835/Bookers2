class SearchsController < ApplicationController

  # 検索機能
  def search
    @model = params["search"]["model"]
    @content = params["search"]["content"]
    @how = params["search"]["how"]
    @dates = search_for(@how, @model, @content)
    if @model == "user"
       @users = @dates
       @book = Book.new
       @user = current_user
       render "users/index"
    end

    if @model == "book"
       @books = @dates
       @book = Book.new
       @user = current_user
       render "books/index"
    end

  end
  # 検索機能

   # 検索機能

   def match(model, content)
     if model == 'user'
       User.where(name:content)
     elsif model == 'book'
       Book.where(title:content)
     end
   end

  def forward(model,content)
    if model == 'user'
      User.where("name LIKE?", "#{content}%")
    elsif model == 'book'
      Book.where("title LIKE?", "#{content}%")
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
