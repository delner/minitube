require 'composite_primary_keys'

class VideoPolicy < ActiveRecord::Base
  after_save :delete_from_cache
  self.primary_keys = :video_id, :country

  attr_accessible :country, :policy_id, :video_id
  belongs_to :video

  # Accessors
  def policy
    Policy.get_policy(self.policy_id)
  end

  # Queries
  def self.by_country_and_policy country, policy
    VideoPolicy.where(:country => country, :policy_id => policy.id)
  end

  def self.available_in_country country
    VideoPolicy.where('country = ? AND policy_id != ?', country, BlockPolicy.id)
  end

  # Caching
  def self.hash_key video_id, country
    ("VideoPolicy-V:" + video_id + "/" + "C:" + country)
  end
  def hash_key
    VideoPolicy.hash_key self.video_id, self.country
  end
  def self.delete_from_cache video_id, country
    Rails.cache.delete VideoPolicy.hash_key video_id, country
  end
  def delete_from_cache
    VideoPolicy.delete_from_cache self.video_id, self.country
  end
  def self.fetch video_id, country
    Rails.cache.fetch (VideoPolicy.hash_key video_id, country) do
      VideoPolicy.find(:video_id => video_id, :country => country)
    end
  end
end
