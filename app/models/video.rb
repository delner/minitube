class Video < ActiveRecord::Base
  before_create :generate_guid
  after_save :delete_from_cache
  self.primary_key = 'id'

  attr_accessible :id, :title
  has_many :video_policies

  # Queries
  def policy_for_country country
    VideoPolicy.fetch self.id, country
  end

  # Caching
  def self.hash_key id
    ("Video-ID:" + id)
  end
  def hash_key
    Video.hash_key self.id
  end
  def self.delete_from_cache id
    Rails.cache.delete Video.hash_key id
  end
  def delete_from_cache
    Video.delete_from_cache self.id
  end
  def self.fetch id
    Rails.cache.fetch (Video.hash_key id) do
      Video.find(id)
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
