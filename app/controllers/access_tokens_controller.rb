class AccessTokensController < ApplicationController
  skip_before_action :authorize!, only: :create

  def create
    authenticator = UserAuthenticator.new(authentication_params)
		authenticator.perform

		render status: :created, json: serializer.new(authenticator.access_token)
  end

  def destroy
    current_user.access_token.destroy
  end

	private

	def serializer
		AccessTokenSerializer
  end
  
  def authentication_params
    (standard_auth_params || params.permit(:code)).to_h.symbolize_keys
  end

  def standard_auth_params
    params.dig(:data, :attributes)&.permit(:login, :password)
  end
end
