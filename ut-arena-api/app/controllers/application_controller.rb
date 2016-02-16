class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session


  before_action :destroy_session  #testing
  #before_action :destroy_session, :authenticate_user!  #production

  def destroy_session
    request.session_options[:skip] = true
  end

  def authenticate_user!
    token, options = ActionController::HttpAuthentication::Token.token_and_options(request)

    user_login = options.blank?? nil : options[:login]
    user = user_login && User.find_by(login: user_login)
    if user && ActiveSupport::SecurityUtils.secure_compare(user.authentication_token, token)
      render json: { error: 463 }, status: 463 unless user.token_expires_at > Time.now
      @current_user = user
    else
      render json: {error: 401}, status:401
    end
  end

end
