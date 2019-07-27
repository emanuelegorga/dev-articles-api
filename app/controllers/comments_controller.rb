class CommentsController < ApplicationController
  skip_before_action :authorize!, only: [:index]
  before_action :load_article

  def index
    comments = @article.comments
    render json: serializer.new(comments)
  end

  def create
    @comment = @article.comments.build(
      comment_params.merge(user: current_user)
    )

    if @comment.save
      render json: @comment, status: :created, location: @article
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  private

  def serializer
		CommentSerializer
  end

  def load_article
    @article = Article.find(params[:article_id])
  end

  def comment_params
    params.require(:comment).permit(:content, :article_id)
  end
end
