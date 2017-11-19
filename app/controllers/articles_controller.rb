class ArticlesController < ApplicationController
 
 def new
   @article = Article.new
 end
 
 def create
  @article = Article.new(article_params)
  if @article.save
   redirect_to article_pat(@article)
  else
   render 'new', notice: "was unable to save the article"
  end
 end
 
 def article_params
  params.require(:article).permit(:title, :description)
 end
end