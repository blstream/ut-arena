class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: :create

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
  def create_params
    params.require(:session).permit(:login, :password)
  end
end
