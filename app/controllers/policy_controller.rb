class PolicyController < ApplicationController
  caches_action :index

  def index
    @policies = VideoPolicy.all
    respond_to do |format|
      format.html
      format.json{
        render :json => @policies.to_json
      }
    end
  end

  def available
    policies = Rails.cache.fetch ('policy#available-C:' + params[:country]) do
      VideoPolicy.available_in_country(params[:country]).to_a
    end
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
    expire_action :action => :index
    Rails.cache.clear
  end
end
