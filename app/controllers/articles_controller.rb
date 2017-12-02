class ArticlesController < ApplicationController
  before_action :find_article, only: [:edit, :update, :show, :destroy]
  before_action :require_user, expect: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  
  def index
   @articles = Article.paginate(page: params[:page], per_page: 5)
  end
  
  def new
    @article = Article.new
  end
  
  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:success] = "The article was succefully saved."
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end
  
  def show
  end
  
  def edit
  end
  
  def update
    if @article.update(article_params)
     flash[:success] = "The article was succefully updated"
     redirect_to article_path(@article)
    else
     render 'edit'
    end
  end
    
  def destroy
   @article.destroy if @article.present?
   flash[:danger] = "Article was succefully deleted."
   redirect_to articles_path
  end
  
  private
  
  def find_article
    @article = Article.find(params[:id])
  end
  
  def article_params
    params.require(:article).permit(:title, :description)
  end
  
  def require_same_user
    if current_user != @article.user
      flash[:danger] = "You cannot edit this article"
      redirect_to root_path
    end
  end

end