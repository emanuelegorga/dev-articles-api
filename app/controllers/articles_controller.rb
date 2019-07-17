class ArticlesController < ApplicationController
  skip_before_action :authorize!, only: [:index, :show]
  # include JsonapiErrorsHandler
  # rescue_from ::StandardError, with: lambda { |e| handle_error(e) }

	def index
		articles = Article.recent.page(current_page).per(per_page)
		render json: serializer.new(articles)
	end

	def show
		render json: serializer.new(Article.find(params[:id]))
  end

  # def show
  #   Article.find(params[:id])
  # rescue ActiveRecord::RecordNotFound
  #   e = Errors::NotFound.new
  #   render json: ErrorSerializer.new(e), status: e.status
  # end

  def create
    # process_operation!(Admin::Article::Operation::Create)

  #   article = Article.new(article_params)
  #   article.save!
  # rescue ActiveRecord::RecordInvalid
  #   raise Errors::Invalid.new(article.errors.to_h)

    if article.valid?
    else
      render json: article, adapter: :json_api,
      serializer: JsonAapiErrorsHandler::Errors::Invalid,
        # serializer: ActiveModel::Serializer::ErrorSerializer,
        status: :unprocessable_entity
    end
  end

  # def update
  #   process_operation!(Admin::Article::Operation::Update)
  # end

	private

	def serializer
		ArticleSerializer
  end

  def article_params
    ActionController::Parameters.new
  end
end
