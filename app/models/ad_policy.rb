class AdPolicy < Policy
  include Singleton

  def self.id
    2
  end

  def self.name
    'Ad Policy'
  end

  def on_show_video
    'This video is ad-supported. Watch an ad first.'
  end
end
