class CategoriesController < ApplicationController

  def index
    @categories = current_user.categories
  end

  def show
    #TODO: filter by current_user
    @category = Category.find(params[:id])
    @totals = @category.totals_for_year Date.today.year
  end

  def new
    @category = Category.new(:user => current_user)
  end

  def edit
    #TODO: filter by current_user
    @category = Category.find(params[:id])
  end

  def create
    @category = Category.new(params[:category])
    @category.user = current_user

    if @category.save
      flash[:notice] = 'Category was successfully created.'
      redirect_to(@category) 
    else
      render :action => "new"
    end
  end

  def update
    #TODO: filter by current_user
    @category = Category.find(params[:id])

    if @category.update_attributes(params[:category])
      flash[:notice] = 'Category was successfully updated.'
      redirect_to(@category)
    else
      render :action => "edit"
    end
  end

  def destroy
    #TODO: filter by current_user
    @category = Category.find(params[:id])
    @category.destroy

    redirect_to(categories_url)
  end
end
