class AccessTokensController < ApplicationController
  skip_before_action :authorize!, only: :create

	def create
		authenticator = UserAuthenticator.new(params[:code])
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
end
