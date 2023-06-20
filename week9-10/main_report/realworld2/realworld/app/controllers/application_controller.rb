class ApplicationController < ActionController::Base
  include AuthenticationConcern
  protect_from_forgery with: :null_session
end
