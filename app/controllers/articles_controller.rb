class ArticlesController < ApplicationController
  skip_before_action :authorize!, only: [:index, :show]

	def index
		articles = Article.recent.page(current_page).per(per_page)
		render json: serializer.new(articles)
	end

	def show
		render json: serializer.new(Article.find(params[:id]))
  end

  def create
    article = Article.new(article_params)

    if article.valid?
      article.save!
      render json: serializer.new(article, status: :created)
    else
      render json: article, adapter: :json_api,
      serializer: ActiveModel::Serializer::ErrorSerializer,
      status: :unprocessable_entity
    end
  end

	private

	def serializer
		ArticleSerializer
  end

  def article_params
    params.require(:data).require(:attributes).permit(:title, :content, :slug) || ActionController::Parameters.new
  end
end
