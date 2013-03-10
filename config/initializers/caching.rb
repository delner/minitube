if Rails.env == "development"
  Dir.glob("#{Rails.root}/app/models/**/*.rb") do |model_name|
    require_dependency model_name
  end
  Rails.cache.clear
  # This is only done for the sake of development,
  # We wouldn't want to do this in the production environment
  Caching.remote_cache.clear
end