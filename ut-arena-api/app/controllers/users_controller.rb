class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: :create

  def create
    @user = User.new(user_params)
    @user.password = params[:password]
    render json: {error: 401}, status:401 unless @user.save
  end


  private

  def user_params
    params.require(:user).permit(:login, :email, :password, :password_confirmation)
  end
end
