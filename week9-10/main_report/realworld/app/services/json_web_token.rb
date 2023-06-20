class JsonWebToken
  # 秘密キーを取得
  HMAC_SECRET = Rails.application.secrets.secret_key_base

  # トークンを生成する
  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, HMAC_SECRET, 'HS256')
  end

  # トークンをデコードする
  def self.decode(token)
    return nil if token.nil?

    body = JWT.decode(token, HMAC_SECRET, true, { algorithm: 'HS256' })[0]
    HashWithIndifferentAccess.new(body)
  rescue JWT::DecodeError => e
    raise "Invalid token, #{e.message}"
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header) if http_auth_header
  end
end
