class Video < ActiveRecord::Base
  before_create :generate_guid
  after_save :delete_from_cache
  self.primary_key = 'id'

  attr_accessible :id, :title
  has_many :video_policies

  # Queries
  def self.all_with_policies
    # I'd like to use active record classes to build this data view out, but it was being inefficient
    # and I couldn't figure out how to map the data the way I wanted. This works well, though.
    query = "SELECT videos.*, video_policies.country, video_policies.policy_id FROM `videos` INNER JOIN `video_policies` ON `video_policies`.`video_id` = `videos`.`id`"
    query_result = ActiveRecord::Base.connection.execute(query)

    result = {}
    # Doesn't let me reference column names... we have to use column indexes.
    # 0 - video_id
    # 1 - title
    # 2 - date_created
    # 3 - date_updated
    # 4 - country
    # 5 - policy_id
    query_result.each do |row|
      if result[row[0]] == nil
        # Add video
        result[row[0]] = {}
        result[row[0]]['id'] = row[0]
        result[row[0]]['title'] = row[1]
        result[row[0]]['created_at'] = row[2]
        result[row[0]]['updated_at'] = row[3]
        result[row[0]]['policies'] = {}
      end

      # Add Policy
      if result[row[0]]['policies'][row[5]] == nil
        # Add first country
        result[row[0]]['policies'][row[5]] = [row[4]]
      else
        # Add subsequent country
        result[row[0]]['policies'][row[5]] << row[4]
      end
    end
    result.values
  end
  def policy_for_country country
    VideoPolicy.fetch self.id, country
  end
  def self.available country
    Video.includes(:video_policies).where('video_policies.country = ? AND video_policies.policy_id != ?', country, BlockPolicy.id)
  end

  # Caching
  def self.hash_key id
    ("Video-ID:" + id)
  end
  def hash_key
    Video.hash_key self.id
  end
  def self.delete_from_cache id
    Caching.remote_cache.delete Video.hash_key id
  end
  def delete_from_cache
    Video.delete_from_cache self.id
  end
  def self.fetch id
    Caching.remote_cache.fetch (Video.hash_key id) do
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
