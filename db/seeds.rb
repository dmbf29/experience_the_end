require 'open-uri'

puts 'Getting Admin users...'
doug = User.find_by(email: 'douglasmberkley@gmail.com') || User.create(email: 'douglasmberkley@gmail.com', password: ENV['ADMIN_PASSWORD'], admin: true, first_name: 'Doug', last_name: 'Berkley')
trouni = User.find_by(email: 'trouni@gmail.com') || User.create(email: 'trouni@gmail.com', password: ENV['ADMIN_PASSWORD'], admin: true, first_name: 'Trouni', last_name: 'Tiet')
sasha = User.find_by(email: 'sasha.kaverina@gmail.com') || User.create(email: 'sasha.kaverina@gmail.com', password: ENV['ADMIN_PASSWORD'], admin: true, first_name: 'Sasha', last_name: 'Kaverina')
yann = User.find_by(email: 'yann.luc.klein@gmail.com') || User.create(email: 'yann.luc.klein@gmail.com', password: ENV['ADMIN_PASSWORD'], admin: true, first_name: 'Yann', last_name: 'Klein')
derek = User.find_by(email: 'derek.n.torres@gmail.com') || User.create(email: 'derek.n.torres@gmail.com', password: ENV['ADMIN_PASSWORD'], admin: true, first_name: 'Derek', last_name: 'Torres')
noemi = User.find_by(email: 'noemi.calanducci@gmail.com') || User.create(email: 'noemi.calanducci@gmail.com', password: ENV['ADMIN_PASSWORD'], admin: true, first_name: 'Noemi', last_name: 'Ashizuka')

unless doug.photo.attached?
  file = file = URI.open('https://res.cloudinary.com/wagon/image/upload/c_fill,g_face,h_200,w_200/v1523933095/viqfqp0tfkmcwmj7cfwe.jpg')
  doug.photo.attach(io: file, filename: 'user.png', content_type: 'image/png')
end

unless trouni.photo.attached?
  file = file = URI.open('https://avatars.githubusercontent.com/u/34345789?v=4')
  trouni.photo.attach(io: file, filename: 'user.png', content_type: 'image/png')
end

unless sasha.photo.attached?
  file = file = URI.open('https://avatars.githubusercontent.com/u/63218144?v=4')
  sasha.photo.attach(io: file, filename: 'user.png', content_type: 'image/png')
end

unless yann.photo.attached?
  file = file = URI.open('https://avatars.githubusercontent.com/u/26819547?v=4')
  yann.photo.attach(io: file, filename: 'user.png', content_type: 'image/png')
end

unless derek.photo.attached?
  file = file = URI.open('https://res.cloudinary.com/wagon/image/upload/c_fill,g_face,h_200,w_200/v1625501928/uti26nayfjxxsytkim0k.jpg')
  derek.photo.attach(io: file, filename: 'user.png', content_type: 'image/png')
end

unless noemi.photo.attached?
  file = file = URI.open('https://res.cloudinary.com/wagon/image/upload/c_fill,g_face,h_200,w_200/v1581465654/ald6cwc2teqzuzavawdt.jpg')
  noemi.photo.attach(io: file, filename: 'user.png', content_type: 'image/png')
end

members = [doug, trouni, sasha, yann, derek, noemi]

# puts "Cleaning all other users..."
# Users.where.not(id: members).destroy_all

puts "Only creating Users if they don't exist. (Photos take time...)"
if User.count < 30
  puts "Yep you needed Users"
  bar = ProgressBar.new(30)
  30.times do
    file = URI.open('https://thispersondoesnotexist.com/image')
    user = User.create!(
      email: Faker::Internet.safe_email,
      password: '123123',
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name
    )
    user.photo.attach(io: file, filename: 'user.png', content_type: 'image/png')
    bar.increment!
  end
  puts "...Created #{User.count} users"
end

puts "Cleaning up experiences and bookings..."
Booking.destroy_all
Experience.destroy_all
puts "...done"

puts "Creating experiences..."
experiences = {
  'Russian Roulette' => { image_urls: %w[https://d4r15a7jvr7vs.cloudfront.net/ewoJICAgICAgICAgICAgICAgICJidWNrZXQiOiAiZmlsZXMubGJyLmNsb3VkIiwKCSAgICAgICAgICAgICAgICAia2V5IjogInB1YmxpYy93a29pMWx4aTlkbzRwNm5yb2J4OC5qcGciLAoJICAgICAgICAgICAgICAgICJlZGl0cyI6IHsKCSAgICAgICAgICAgICAgICAgICJyZXNpemUiOiB7CgkgICAgICAgICAgICAgICAgICAgICJ3aWR0aCI6IDk0NSwKCSAgICAgICAgICAgICAgICAgICAgImhlaWdodCI6IDUyNiwKCSAgICAgICAgICAgICAgICAgICAgImZpdCI6ICJjb3ZlciIKCSAgICAgICAgICAgICAgICAgIH0KCSAgICAgICAgICAgICAgICB9CgkgICAgICAgICAgICB9] },
  'Lying on Train Tracks' => { image_urls: %w[https://d2gg9evh47fn9z.cloudfront.net/800px_COLOURBOX2198605.jpg] },
  'Cliff Jumping' => { image_urls: %w[https://miro.medium.com/max/1200/1*dbRtigtUHycinvxBbzACUw.jpeg https://img1.10bestmedia.com/Images/Photos/317046/photo_54_990x660.jpg https://miro.medium.com/max/7784/1*8QNk1Je0Lwr2muxoVs555A.jpeg] },
  'Blindfold Driving' => { image_urls: %w[https://media.gettyimages.com/photos/child-covering-eyes-of-her-mother-while-driving-car-picture-id1254043706?k=20&m=1254043706&s=612x612&w=0&h=Xrxc2-DYeFYLnKeW5_I9CCG-t4eE-Hg0N8BspQJLaRk= https://www.thefloodlawfirm.com/wp-content/uploads/2021/08/what-are-dangers-of-speeding.jpg https://www.nottinghamoffroadevents.co.uk/_webedit/cached-images/331-0-0-0-10000-10000-536.jpg] },
  'Jetskiing with Sharks' => { image_urls: %w[https://i.ytimg.com/vi/fBCSZpHTnjI/maxresdefault.jpg https://img.redbull.com/images/c_crop,x_0,y_0,h_2848,w_3164/c_fill,w_860,h_782/q_auto,f_auto/redbullcom/2018/07/06/c8eb4913-6df0-4bd7-b6e9-4f24f02c0e81/jetskiing-collection https://ychef.files.bbci.co.uk/976x549/p07k4hnq.jpg] },
  'Swimming with Alligators' => { image_urls: %w[https://www.hola.com/us/images/025e-0f96b9f13dd6-18f93d88afaf-1000/square-800/gator.jpg] },
  'Hippo Rodeo' => { image_urls: %w[https://cdn.hswstatic.com/gif/hippo-sunscreen.jpg] },
  'Mountain Biking Everest' => { image_urls: %w[https://cdn.hiconsumption.com/wp-content/uploads/2019/01/Best-Winter-Mountain-Biking-Gear-0-Hero-1087x725.jpg https://i.dailymail.co.uk/i/pix/2012/06/17/article-2160665-13A64880000005DC-860_634x416.jpg https://cycling.today/wp-content/uploads/2018/11/cliffs-of-moher1.jpg] },
  'Helicopter Obstacle Course' => { image_urls: %w[https://corporatehelicopters.b-cdn.net/wp-content/uploads/america-sailing-cup-720x480.jpg] },
  'Highway Car Jumping' => { image_urls: %w[https://media.gq.com/photos/55828968e52bc4b477a972b1/1:1/w_450,h_450,c_limit/blogs-the-feed-man-jumps-from-car-635.jpg https://h7.alamy.com/comp/2BH8K29/happy-middle-age-woman-jumping-outside-a-red-vintage-van-while-traveling-fast-on-the-road-for-the-joy-to-start-the-vacation-or-adventure-wanderlust-lifestyle-for-alternative-holiday-people-2BH8K29.jpg https://s1.cdn.autoevolution.com/images/news/man-jumps-from-moving-car-to-end-arguing-with-his-girlfriend-84330_1.jpg] }
}
prices = [500, 1000, 1500, 2000, 2500, 3000]

bar = ProgressBar.new(experiences.length)
experiences.each do |name, info|
  start_hour = rand(8..20)
  start_time = Time.new(Time.now.year, nil, nil, start_hour, nil, nil,nil)
  end_time = start_time + [60, 90, 120, 150, 180, 210, 240].sample.minutes
  experience = Experience.create!(
    name: name,
    description: Faker::Lorem.paragraph,
    price: prices.sample,
    address: Faker::Address.street_address,
    latitude: Faker::Address.latitude,
    longitude: Faker::Address.longitude,
    user: User.all.sample,
    start_time: start_time,
    end_time: end_time
  )
  info[:image_urls].each do |image_url|
    file = URI.open(image_url)
    experience.photos.attach(io: file, filename: 'experience.jpg', content_type: 'image/jpg')
  end
  bar.increment!
end
puts "Created #{Experience.count} experiences..."

puts "Creating 2 bookings for each user"
bar = ProgressBar.new(User.count * 2)
User.find_each do |user|
  experiences = Experience.all.sample(2)
  experiences.each do |experience|
    booking = Booking.new(
      user: user,
      experience: experience,
      date: Date.today + rand(5..20),
      participants: rand(1..3)
    )
  booking.save!
  end
  bar.increment!
end
puts "Created #{Booking.count} bookings..."
