class ApplicationController < ActionController::Base
  include ActionController::RespondWith
  skip_before_action :verify_authenticity_token
end
