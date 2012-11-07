CarrierWave.configure do |config|
  config.cache_dir = "#{Rails.root}/data/sitemaps/"
  config.storage = :fog
  config.permissions = 0666
  config.fog_credentials = {
    :provider               => "AWS",
    :aws_access_key_id      => Settings.aws_access_key_id,
    :aws_secret_access_key  => Settings.aws_secret_access_key,
  }

  config.fog_directory = "ristoran8"
  config.fog_attributes = {"Cache-Control"=>"max-age=315576000"}
  config.fog_host = "http://cdn1.ristoran8.com"
end