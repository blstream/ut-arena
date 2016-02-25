# Users Controller Class
class UsersController < ApplicationController

  # The authenticate_user! method is skipped only for create method
  # without that, user would not be able to log in
  skip_before_action :authenticate_user!, only: :create

  # Public: Create method is responsible for creating user
  def create
    @user = User.new(user_params)
    @user.password = params[:password]
    render json: {error: 401}, status:401 unless @user.save
  end


  private

  # Private: Strong Params for User Object
  def user_params
    params.require(:user).permit(:login, :email, :password, :password_confirmation)
  end
end
