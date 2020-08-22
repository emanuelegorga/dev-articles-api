class HealthcheckController < ApplicationController
  skip_before_action :authorize!

  def index
    render json: { healthcheck: true }
  end
end
