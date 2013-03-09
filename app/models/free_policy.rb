class FreePolicy < Policy
  include Singleton

  def self.id
    1
  end

  def self.name
    'Free Policy'
  end

  def on_show_video
    'This video is free, play it.'
  end
end
