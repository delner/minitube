require 'test_helper'

class VideoPolicyTest < ActiveSupport::TestCase
  fixtures :videos

  test "has a country" do
    cat_video_us = VideoPolicy.where(:video_id => video_policies(:cat_video_us).video_id, :country => video_policies(:cat_video_us).country)[0]
    assert cat_video_us.country
  end

  test "has a policy" do
    cat_video_us = VideoPolicy.where(:video_id => video_policies(:cat_video_us).video_id, :country => video_policies(:cat_video_us).country)[0]
    assert cat_video_us.policy
  end

  test "has AdPolicy videos in US" do
    ad_policy_videos = VideoPolicy.by_country_and_policy 'US', AdPolicy
    assert ad_policy_videos.length > 0
  end
end