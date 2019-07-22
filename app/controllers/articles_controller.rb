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
    article = current_user.articles.build(article_params)
    article.save!
    render status: :created, json: serializer.new(article)
  rescue
    render json: article, adapter: :json_api,
      serializer: ActiveModel::Serializer::ErrorSerializer,
      status: :unprocessable_entity
  end

  def update
    article = current_user.articles.find(params[:id])
    article.update_attributes!(article_params)
    render status: :ok, json: serializer.new(article)
  rescue ActiveRecord::RecordNotFound
    authorization_error
  rescue
    render json: article, adapter: :json_api,
      serializer: ActiveModel::Serializer::ErrorSerializer,
      status: :unprocessable_entity
  end

  def destroy
    article = current_user.articles.find(params[:id])
    article.destroy
    head :no_content
  rescue
    authorization_error
  end

	private

	def serializer
		ArticleSerializer
  end

  def article_params
    params.require(:data).require(:attributes).permit(:title, :content, :slug) || ActionController::Parameters.new
  end
end
