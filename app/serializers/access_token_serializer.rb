class AccessTokenSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :token
end
