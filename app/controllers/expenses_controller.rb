class ExpensesController < ApplicationController
 
  def index
  	if (not params[:year].nil? and not params[:month].nil?)
  		@expenses = Expense.find_by_year_month params[:year], params[:month] 
    else
    	@expenses = Expense.all
  	end
  end
  
  def show
    @expense = Expense.find(params[:id])
  end

  def new
    @expense = Expense.new
  end

  def edit
    @expense = Expense.find(params[:id])
  end

  def create
    @expense = Expense.new(params[:expense])
	  if @expense.save
	    flash[:notice] = 'Expense was successfully created.'
	    redirect_to(@expense)
	  else
	    render :action => "new" 
	  end
  end

  def update
    @expense = Expense.find(params[:id])
    if @expense.update_attributes(params[:expense])
      flash[:notice] = 'Expense was successfully updated.'
      redirect_to(@expense)
    else
    	render :action => "edit" 
    end
  end

  def destroy
    @expense = Expense.find(params[:id])
    @expense.destroy
    redirect_to(expenses_url)
  end
end
