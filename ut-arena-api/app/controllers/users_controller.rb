class UsersController < ApplicationController

  def create
    @user = User.create(user_params)
    @user.save
  end


  private

  def user_params
    params.require(:user).permit(:login, :email, :password)
  end
end
