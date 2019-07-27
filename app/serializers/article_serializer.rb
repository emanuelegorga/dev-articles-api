class ArticleSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :title, :content, :slug
end
