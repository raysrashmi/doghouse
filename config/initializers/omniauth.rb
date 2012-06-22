PROVIDER = YAML.load_file("#{Rails.root}/config/provider.yml")[Rails.env]

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, PROVIDER['twitter']['key'], PROVIDER['twitter']['secret']
end
#
Twitter.configure do |config|
  config.consumer_key = PROVIDER['twitter']['key']
  config.consumer_secret = PROVIDER['twitter']['secret']
  config.oauth_token = PROVIDER['twitter']['oauth_token']
  config.oauth_token_secret = PROVIDER['twitter']['oauth_token_secret']
end
