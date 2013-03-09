class VideoPolicy < ActiveRecord::Base
  attr_accessible :country, :policy_id, :video_id
  belongs_to :video

  def self.hash_key video_id, country
    ("VideoPolicy-V:" + video_id + "/" + "C:" + country)
  end
  def hash_key
    VideoPolicy.hash_key self.id, self.country
  end

  def self.by_country_and_policy country, policy
    VideoPolicy.where(:country => country, :policy_id => policy.id)
  end

  def self.available_in_country country
    VideoPolicy.where('country = ? AND policy_id != ?', country, BlockPolicy.id)
  end

  def policy
    Policy.get_policy(self.policy_id)
  end
end
