# include CanCan::ControllerAdditions::ClassMethods

class CategoriesController < ApplicationController

  def index
    @categories = current_user.categories
  end

  def show
    @category = Category.find(params[:id])
    redirect_to root_url unless @category.user == current_user
  end

  def new
    @category = Category.new(:user => current_user)
    @colors = Color.all
  end

  def edit
    @category = Category.find(params[:id])
    authorize_resource(@category) do
      @colors = Color.all
    end
  end

  def create
    @category = Category.new(params[:category])
    @category.user = current_user

    if @category.save
      flash[:notice] = 'Category was successfully created.'
      redirect_to categories_url
    else
      render :action => "new"
    end
  end

  def update
    @category = Category.find(params[:id])

    authorize_resource @category do
      if @category.update_attributes(params[:category])
        flash[:notice] = 'Category was successfully updated.'
        redirect_to categories_url
      else
        render :action => "edit"
      end
    end
  end

  def destroy
    @category = Category.find(params[:id])
    authorize_resource @category do
      @category.destroy
      redirect_to(categories_url)
    end
  end

end
