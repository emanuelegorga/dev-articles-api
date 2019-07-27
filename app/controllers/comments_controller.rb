class CommentsController < ApplicationController
  skip_before_action :authorize!, only: [:index]
  before_action :load_article

  def index
    comments = @article.comments.page(current_page).per(per_page)
    render json: serializer.new(comments)
  end

  def create
    comment = @article.comments.build(
      comment_params.merge(user: current_user)
    )
    comment.save!
    render json: serializer.new(comment), status: :created, location: @article
  rescue
    render json: comment, adapter: :json_api,
      serializer: ActiveModel::Serializer::ErrorSerializer,
      status: :unprocessable_entity
  end

  private

  def serializer
		CommentSerializer
  end

  def load_article
    @article = Article.find(params[:article_id])
  end

  def comment_params
    params.require(:data).require(:attributes).permit(:content) || ActionController::Parameters.new
  end
end
