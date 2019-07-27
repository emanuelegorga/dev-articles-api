class CommentSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :content
  has_one :article
  has_one :user
end
