# This class is the Application controller
#
# Every action defined here like before_action or rescure_from whould
# be executed in all controllers in the Application
class ApplicationController < ActionController::Base
  # Session is disabled for API
  protect_from_forgery with: :null_session

  # Respond to record not found with method not found
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  # Before every action execute destroy_session and restrict_access methods
  before_action :destroy_session, :restrict_access

  # Public: session is skipped in this method
  def destroy_session
    request.session_options[:skip] = true
  end

  # Public: This method checks the Token sent by the user
  # if the token is valid and not experied user gets the access to the content
  #
  # Returns the current user, token experied or invalid token error
  def authenticate_user!
    token, options = ActionController::HttpAuthentication::Token.token_and_options(request)

    user_login = options.blank?? nil : options[:login]
    user = user_login && User.find_by(login: user_login)
    if user && ActiveSupport::SecurityUtils.secure_compare(user.authentication_token, token)
      render json: { error: 463 }, status: 463 if user.token_expires_at < Time.now
      @current_user = user
    else
      render json: {error: 401}, status:401
    end
  end


  protected

  # Protected: Checks if the Authentication should be enabled
  def restrict_access
    authenticate_user! if AUTHENTICATION
  end


  private

  # Private: Returns 404 error
  def not_found
    render json: {error: 404}, status: 404
  end
end
