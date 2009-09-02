class MovementsController < ApplicationController

  def index
    @movements = Movement.all
  end

  def show
    @movement = Movement.find(params[:id])
  end

  def new
    @movement = Movement.new
  end

  def edit
    @movement = Movement.find(params[:id])
  end

  def create
    @movement = Movement.new(params[:movement])

    if @movement.save
      flash[:notice] = 'Movement was successfully created.'
      redirect_to(@movement) 
    else
      render :action => "new"
    end
  end

  def update
    @movement = Movement.find(params[:id])

    if @movement.update_attributes(params[:movement])
      flash[:notice] = 'Movement was successfully updated.'
      redirect_to(@movement)
    else
      render :action => "edit"
    end
  end

  def destroy
    @movement = Movement.find(params[:id])
    @movement.destroy

    redirect_to(movements_url)
  end
end
