require 'openssl'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV["FACEBOOK_APPID_#{::Rails.env.upcase}"], ENV["FACEBOOK_SECRET_#{::Rails.env.upcase}"]
end

if ::Rails.env == "development"
  OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
end
