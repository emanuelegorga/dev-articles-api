class ApplicationController < ActionController::API
  class AuthorizationError < StandardError; end

  rescue_from UserAuthenticator::AuthenticationError, with: :authentication_error
  rescue_from AuthorizationError, with: :authorization_error

  before_action :authorize!

	def current_page
		return 1 unless params[:page]
		return params[:page] if params[:page].is_a?(String)
		params.dig(:page, :number) if params[:page].is_a?(Hash)
	end

  def per_page
    return unless params[:page]
    return params[:per_page] if params[:per_page].is_a?(String)
    params.dig(:page, :size) if params[:page].is_a?(Hash)
  end

  private

  def authorize!
    raise AuthorizationError unless current_user    
  end

  def access_token
    provided_token = request.authorization&.gsub(/\ABearer\s/, '')
    @access_token = AccessToken.find_by(token: provided_token)
  end

  def current_user
    @current_user = access_token&.user
  end

	def authentication_error
		error = {
			"status" => "401",
			"source" => { "pointer" => "/code" },
			"title" =>  "Authentication code is invalid",
			"detail" => "You must provide valid code in order to exchange it for token."
		}
		render json: { "errors": [ error ] }, status: 401
  end
  
  def authorization_error
    error =
      {
        "status" => "403",
        "source" => { "pointer" => "/headers/authorization" },
        "title" =>  "Not authorized",
        "detail" => "You have no rights to access this resource."
      }
    render json: { "errors": [ error ] }, status: 403
  end
end
