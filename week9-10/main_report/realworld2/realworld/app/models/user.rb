class User < ApplicationRecord
  has_secure_password
  has_many :articles
  def token
    JWT.encode({ user_id: self.id }, Rails.application.secrets.secret_key_base, 'HS256')
  end
end