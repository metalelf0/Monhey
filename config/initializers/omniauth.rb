Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "664808820203339", ENV["FACEBOOK_SECRET"]
end
