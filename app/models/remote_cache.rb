module Caching
  @@remote_cache = ActiveSupport::Cache::MemCacheStore.new("localhost")
  def self.remote_cache
    @@remote_cache
  end
end