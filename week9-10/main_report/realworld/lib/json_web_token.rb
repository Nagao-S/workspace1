def self.decode(token)
  body = JWT.decode(token, HMAC_SECRET, true, { algorithm: 'HS256' })[0]
  HashWithIndifferentAccess.new body
rescue JWT::DecodeError => e
  raise "Invalid token, #{e.message}"
end