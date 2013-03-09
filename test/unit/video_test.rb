require 'test_helper'

class VideoTest < ActiveSupport::TestCase
  fixtures :videos

  test "has an id" do
    cat_video = Video.find(videos(:cat_video).id)
    assert cat_video.id
  end

  test "has policies" do
    cat_video = Video.find(videos(:cat_video).id)
    assert cat_video.video_policies.length > 0
  end
end
