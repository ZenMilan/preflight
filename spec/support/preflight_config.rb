require 'dotenv'
Dotenv.load

Preflight.configure do |config|
  config.github_key = ENV['GITHUB_KEY']
  config.github_secret_key = ENV['GITHUB_SECRET_KEY']
  config.admin_teams = [
    'launchacademy/experience engineers',
    'launchacademy/admins'
  ]
  config.facebook_app_id = ENV['FACEBOOK_APP_ID']
end
