class BlockPolicy < Policy
  include Singleton

  def self.id
    0
  end

  def self.name
    'Block Policy'
  end

  def on_show_video
    'This video is blocked. :('
  end
end
