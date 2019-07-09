class ApplicationController < ActionController::API

  rescue_from UserAuthenticator::AuthenticationError, with: :authentication_error

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

	def authentication_error
		error = {
			"status" => "401",
			"source" => { "pointer" => "/code" },
			"title" =>  "Authentication code is invalid",
			"detail" => "You must provide valid code in order to exchange it for token."
		}
		render json: { "errors": [ error ] }, status: 401
	end
end
