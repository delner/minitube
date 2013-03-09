class VideoPolicy < ActiveRecord::Base
  attr_accessible :country, :policy_id, :video_id
  belongs_to :video

  def policy
    Policy.get_policy(self.policy_id)
  end
end
