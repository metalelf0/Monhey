class SessionsController < ApplicationController
  def new
  end

  def create
    # binding.pry
    auth_hash = request.env['omniauth.auth']
 
    if session[:user_id]
      # Means our user is signed in. Add the authorization to the user
      User.find(session[:user_id]).add_provider(auth_hash)
 
      flash[:notice] = "You can now login using #{auth_hash["provider"].capitalize} too!"
    else
      # Log him in or sign him up
      auth = Authorization.find_or_create(auth_hash)
 
      # Create the session
      @user = auth.user
      @user.update_attribute(:profile_pic, auth_hash["info"]["image"])
      session[:user_id] = @user.id
 
      flash[:notice] = "Welcome #{auth.user.name}!"
    end
    redirect_to root_path
  end

  def failure
    flash[:alert] = "Sorry, but you didn't allow access to our app!"
    redirect_to root_path
  end
  
  def destroy
    session[:user_id] = nil
    flash[:notice] = "You've logged out!"
    redirect_to root_path
  end
end
