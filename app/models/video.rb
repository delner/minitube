class Video < ActiveRecord::Base
  before_create :generate_guid
  self.primary_key = 'id'

  attr_accessible :id, :title

  has_many :video_policies

  def policy_for_country country
    Rails.cache.fetch (self.id + "/" + country) do
      VideoPolicy.where(:video_id => self.id, :country => country)[0]
    end
  end

  protected
  def generate_guid
    begin
      id = SecureRandom.urlsafe_base64.to_s[0,8]
    end while Video.where(:id => id).exists?
    self.id = id
  end
end