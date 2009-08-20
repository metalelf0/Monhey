class AccountsController < ApplicationController
  # GET /accounts
  # GET /accounts.xml
  def index
    @accounts = Account.all
  end

  # GET /accounts/1
  # GET /accounts/1.xml
  def show
    @account = Account.find(params[:id])
  end

  # GET /accounts/new
  # GET /accounts/new.xml
  def new
    @account = Account.new
  end

  # GET /accounts/1/edit
  def edit
    @account = Account.find(params[:id])
  end

  # POST /accounts
  # POST /accounts.xml
  def create
    @account = Account.new(params[:account])
    if @account.save
      flash[:notice] = 'Account was successfully created.'
      redirect_to(@account)
    else
      render :action => "new"
    end  
  end

  # PUT /accounts/1
  # PUT /accounts/1.xml
  def update
    @account = Account.find(params[:id])
    if @account.update_attributes(params[:account])
      flash[:notice] = 'Account was successfully updated.'
      redirect_to(@account)
    else
      render :action => "edit"
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.xml
  def destroy
    @account = Account.find(params[:id])
    @account.destroy
    redirect_to(accounts_url)
  end
  
end
