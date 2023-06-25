class ApplicationController < ActionController::Base
  include ActionController::RespondWith
  # トークンの検証をスキップ
  skip_before_action :verify_authenticity_token
end
