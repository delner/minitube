class PolicyController < ApplicationController
  caches_action :index, :cache_path => Proc.new {|controller| controller.params }
  caches_action :available, :cache_path => Proc.new {|controller| controller.params }

  def index
    # I want to page cache this, but Rails isn't playing nicely with JSON output...
    # Use Memcached for now instead.
    policies = VideoPolicy.all
    respond_to do |format|
      format.html
      format.json{
        render :json => policies.to_json
      }
    end
  end

  def available
    # I want to page cache this, but Rails isn't playing nicely with JSON output...
    # Use Memcached for now instead.
    policies = VideoPolicy.available_in_country(params[:country])
    respond_to do |format|
      format.html
      format.json{
        render :json => policies.to_json
      }
    end
  end

  def video
    video_policy = VideoPolicy.fetch params[:video_id], params[:country]
    respond_to do |format|
      format.html
      format.json{
        render :json => video_policy.to_json
      }
    end
  end

  def expire
    Rails.cache.clear
    Caching.remote_cache.clear
  end
end
