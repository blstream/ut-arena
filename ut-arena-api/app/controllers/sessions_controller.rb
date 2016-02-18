# Sessions Controller Class responisble for authentication of the users
class SessionsController < ApplicationController

  # The authenticate_user! method is skipped only for create method
  # without that, user would not be able to log in
  skip_before_action :authenticate_user!, only: :create

  # Public: Create method is responsible for checking if the provided
  # user is valid for the user.
  #
  # Returns the user id and login together with the authentication token
  def create
    @user = User.find_by(login: create_params[:login])
    if @user.password == create_params[:password]
      @user.generate_authentication_token
      @user.save
    else
      render json: {error: 401}, status:401
    end
  end


  private

  # Private: Strong Params for the session object
  def create_params
    params.require(:session).permit(:login, :password)
  end
end
