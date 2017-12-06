class CategoriesController < ApplicationController
  before_action :require_admin, only: [:new, :create, :edit, :update, :destroy]
  before_action :find_category, only: [:show, :edit, :update, :destroy]
  
  def index
    @categories = Category.paginate(page: params[:page], per_page: 5)
  end
  
  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] =  "Category was created succefully"
      redirect_to categories_path
    else
      render 'new'
    end
  end
  
  def edit
    
  end
  
  def update
    if @category.update(category_params)
      flash[:success] = "The category was succefully updated"
      redirect_to category_path(@category)
    else
      render 'edit'
    end
  end
  
  def destroy
    @category.destroy if @category.present?
    flash[:danger] = "Category was succefully deleted"
    redirect_to categories_path
  end

  def show
    @category_articles = @category.articles.paginate(page: params[:page], per_page: 1)
  end
  
  private
  
  def category_params
    params.require(:category).permit(:name)
  end
  
  def require_admin
    if !logged_in? || (logged_in? && !current_user.admin?)
      flash[:danger] =  "Only admins can perform that action"
      redirect_to categories_path
    end
  end
  
  def find_category
    @category = Category.find(params[:id])
  end
end