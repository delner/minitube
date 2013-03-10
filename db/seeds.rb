# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Generate videos

stress_level = 10

puts('Stress Scale = ' + stress_level.to_s + ' (' + (10*stress_level).to_s + ' videos)')
video_range = (0..((10*stress_level)-1))
country_range = ['US', 'CA', 'MX', 'CN', 'IN', 'TW']
#country_range = ['US', 'CA', 'MX', 'FR', 'GB', 'GR', 'IE', 'CN', 'IN', 'TW']

puts('Destroying existing data...')
ActiveRecord::Base.connection.execute("TRUNCATE TABLE video_policies;")
ActiveRecord::Base.connection.execute("TRUNCATE TABLE videos;")

puts('Generating videos...')
videos = []
video_range.each do |i|
  if i == video_range.count / 4
    puts('25%...')
  elsif i == video_range.count / 2
    puts('50%...')
  elsif i == video_range.count - (video_range.count / 4)
    puts('75%...')
  end

  v = Video.new
  v.id = i
  v.title = ('Vid' + ("%02d" % i))

  videos << v
end
puts('Importing videos...')
Video.import videos

puts('Generating video policies...')
video_policies = []
videos.each do |v|
  if v.id == videos.length / 4
    puts('25%...')
  elsif v.id == videos.length / 2
    puts('50%...')
  elsif v.id == videos.length - (videos.length / 4)
    puts('75%...')
  end
  
  country_range.each do |c|
    vp = VideoPolicy.new
    vp.video_id = v.id
    vp.country = c
    vp.policy_id = rand(3)

    video_policies << vp
  end
end
puts('Importing video policies...')
VideoPolicy.import video_policies