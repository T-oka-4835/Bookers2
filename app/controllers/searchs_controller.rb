class SearchsController < ApplicationController
  
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
