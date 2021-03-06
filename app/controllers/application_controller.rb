# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Authenticable
  include Pagy::Backend
end
