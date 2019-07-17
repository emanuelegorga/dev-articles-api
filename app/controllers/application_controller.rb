class ApplicationController < ActionController::API
  class AuthorizationError < StandardError; end

  include JsonapiErrorsHandler
  rescue_from ::StandardError, with: lambda { |e| handle_error(e) }

  # include Api::ErrorHandler

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

  # def authorize!
  #   raise Errors::Unauthorized unless current_user
  # end

  # def process_operation!(klass)
  #   result = klass.(serialized_params)
  #   return render_success if result.success?
  #   raise Errors::Invalid.new(result['contract.default'].errors.to_h)
  # end

  # def serialized_params
  #   data = params[:data].merge(id: params[:id])
  #   data.reverse_merge(id: data[:id])
  # end

  # def render_success
  #   render json: serializer.new(result['model']), status: success_http_status
  # end

  # def success_http_status
  #   return 201 if params[:action] == 'create'
  #   return 204 if params[:action] == 'destroy'
  #   return 200
  # end

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
