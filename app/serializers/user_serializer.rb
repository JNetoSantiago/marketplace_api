# frozen_string_literal: true

class UserSerializer
  include JSONAPI::Serializer
  attributes :email

  # relationships
  has_many :products

  cache_options store: Rails.cache, namespace: 'jsonapi-serializer', expires_in: 1.hour
end
