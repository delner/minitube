# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Generate videos
puts('Seeding videos...')
Video.destroy_all
videos = []
(0..99).each do |i|
  v = Video.new
  v.title = ('Vid' + ("%02d" % i))

  videos << v
  v.save
end

puts('Seeding video policies...')
VideoPolicy.destroy_all
video_policies = []
videos.each do |v|
  ['US', 'CA', 'MX', 'CN', 'IN', 'TW'].each do |c|
    vp = VideoPolicy.new
    vp.video_id = v.id
    vp.country = c
    vp.policy_id = rand(3)

    video_policies << vp
    vp.save
  end
end