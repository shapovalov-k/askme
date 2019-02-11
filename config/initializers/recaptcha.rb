# Настройки гема recaptcha
Recaptcha.configure do |config|
  config.site_key  = ENV['RECAPTCHA_ASKMEASK_PUBLIC_KEY']
  config.secret_key = ENV['RECAPTCHA_ASKMEASK_PRIVATE_KEY']
end
