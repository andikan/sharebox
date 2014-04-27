class FacebookSettings < Settingslogic
  source File.join(Rails.root, "config", "facebook.yml")
  namespace Rails.env
end
