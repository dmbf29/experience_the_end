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
# Should 2-4 photos
experiences = {
  'Russian Roulette' => { image_urls: %w[https://cdni.rbth.com/rbthmedia/images/2020.09/article/5f635cd815e9f96e561ab183.jpg https://d4r15a7jvr7vs.cloudfront.net/ewoJICAgICAgICAgICAgICAgICJidWNrZXQiOiAiZmlsZXMubGJyLmNsb3VkIiwKCSAgICAgICAgICAgICAgICAia2V5IjogInB1YmxpYy93a29pMWx4aTlkbzRwNm5yb2J4OC5qcGciLAoJICAgICAgICAgICAgICAgICJlZGl0cyI6IHsKCSAgICAgICAgICAgICAgICAgICJyZXNpemUiOiB7CgkgICAgICAgICAgICAgICAgICAgICJ3aWR0aCI6IDk0NSwKCSAgICAgICAgICAgICAgICAgICAgImhlaWdodCI6IDUyNiwKCSAgICAgICAgICAgICAgICAgICAgImZpdCI6ICJjb3ZlciIKCSAgICAgICAgICAgICAgICAgIH0KCSAgICAgICAgICAgICAgICB9CgkgICAgICAgICAgICB9 https://www.ladbible.com/cdn-cgi/image/width=720,quality=70,format=jpeg,fit=pad,dpr=1/https%3A%2F%2Fs3-images.ladbible.com%2Fs3%2Fcontent%2F280fe5265806db00c51b621549929495.jpg https://media.istockphoto.com/photos/russian-roulette-concept-picture-id460629527?k=20&m=460629527&s=612x612&w=0&h=y7H1eMU-Gc-1HSccd3SLPBsPg2xu7ZtyNOF-2K9jwcE=] },
  'Lying on Train Tracks' => { image_urls: %w[https://d2gg9evh47fn9z.cloudfront.net/800px_COLOURBOX2198605.jpg https://images.pexels.com/photos/1782355/pexels-photo-1782355.jpeg https://www.wowshack.com/wp-content/uploads/2015/04/d8d3863624adeedd91d6468fd0fe556c.jpeg https://i.pinimg.com/736x/0e/f6/f2/0ef6f2c5d59d6471127c3e971813f037--woman-tied-up-train-tracks.jpg] },
  'Cliff Jumping' => { image_urls: %w[https://miro.medium.com/max/1200/1*dbRtigtUHycinvxBbzACUw.jpeg https://img1.10bestmedia.com/Images/Photos/317046/photo_54_990x660.jpg https://miro.medium.com/max/7784/1*8QNk1Je0Lwr2muxoVs555A.jpeg https://media.tacdn.com/media/attractions-splice-spp-674x446/07/85/f3/cd.jpg] },
  'Blindfold Driving' => { image_urls: %w[https://media.gettyimages.com/photos/child-covering-eyes-of-her-mother-while-driving-car-picture-id1254043706?k=20&m=1254043706&s=612x612&w=0&h=Xrxc2-DYeFYLnKeW5_I9CCG-t4eE-Hg0N8BspQJLaRk= https://www.nottinghamoffroadevents.co.uk/_webedit/cached-images/331-0-0-0-10000-10000-536.jpg https://www.tubefilter.com/wp-content/uploads/2019/01/jake-paul-bird-box.jpg https://imanageproducts.com/wp-content/uploads/2020/06/stressed-man-driving-car-blindfolded.png] },
  'Jet Skiing with Sharks' => { image_urls: %w[https://img.redbull.com/images/c_crop,x_0,y_0,h_2848,w_3164/c_fill,w_860,h_782/q_auto,f_auto/redbullcom/2018/07/06/c8eb4913-6df0-4bd7-b6e9-4f24f02c0e81/jetskiing-collection https://ychef.files.bbci.co.uk/976x549/p07k4hnq.jpg https://i.ytimg.com/vi/fBCSZpHTnjI/maxresdefault.jpg https://www.abc.net.au/news/image/6632606-3x2-940x627.jpg] },
  'Swimming with Alligators' => { image_urls: %w[https://www.hola.com/us/images/025e-0f96b9f13dd6-18f93d88afaf-1000/square-800/gator.jpg https://i2-prod.mirror.co.uk/incoming/article3716455.ece/ALTERNATES/s1227b/Alligator-swim.jpg https://i.ytimg.com/vi/1mw63UO9zxg/maxresdefault.jpg https://scuba-adventures.com/wp-content/uploads/2018/12/file-3.jpg] },
  'Hippo Rodeo' => { image_urls: %w[https://cdn.hswstatic.com/gif/hippo-sunscreen.jpg https://files.worldwildlife.org/wwfcmsprod/images/Hippos_Hero/story_full_width/1tujlsdjl3_Medium_WW1113453.jpg https://blog.planview.com/wp-content/uploads/2020/02/LK_blog_HiPPO_medium-1-1024x683.jpg https://media.istockphoto.com/photos/aggressive-hippo-male-attacking-the-car-picture-id1070002696?k=20&m=1070002696&s=612x612&w=0&h=6X9zCSJhOO_wSMxdLDwKVirrnL4mzDvNF7Oo8gqWDQc=] },
  'Mountain Biking Everest' => { image_urls: %w[https://cdn.hiconsumption.com/wp-content/uploads/2019/01/Best-Winter-Mountain-Biking-Gear-0-Hero-1087x725.jpg https://i.dailymail.co.uk/i/pix/2012/06/17/article-2160665-13A64880000005DC-860_634x416.jpg https://cycling.today/wp-content/uploads/2018/11/cliffs-of-moher1.jpg https://img.redbull.com/images/c_limit,w_1500,h_1000,f_auto,q_auto/redbullcom/2018/04/24/7c2926c6-24c1-467c-8983-efc29102e056/fabioscrub] },
  'Helicopter Obstacle Course' => { image_urls: %w[https://corporatehelicopters.b-cdn.net/wp-content/uploads/america-sailing-cup-720x480.jpg https://arcticinsider.com/Images/Article/201804180704580.jpg https://mediaassets.airbus.com/permalinks/533356/wpr/ascent-helicopters-has-a-growing-fleet-of-h125s.jpg https://i2.wp.com/assets.verticalmag.com/wp-content/uploads/2020/12/Screen-Shot-2020-12-10-at-10.46.44-AM.jpg?fit=2800%2C1799&ssl=1] },
  'Highway Car Jumping' => { image_urls: %w[https://media.gq.com/photos/55828968e52bc4b477a972b1/1:1/w_450,h_450,c_limit/blogs-the-feed-man-jumps-from-car-635.jpg https://s1.cdn.autoevolution.com/images/news/man-jumps-from-moving-car-to-end-arguing-with-his-girlfriend-84330_1.jpg https://freerangestock.com/sample/39777/a-person-jumps-over-a-car.jpg https://i.pinimg.com/736x/99/7a/ca/997aca1f24475e704d6e2c811a6d85cb--parker--jason-statham.jpg] }
}
prices = [500, 1000, 1500, 2000, 2500, 3000]

bar = ProgressBar.new(experiences.length)
experiences.each do |name, info|
  start_hour = rand(8..20)
  start_time = Time.new(Time.now.year, nil, nil, start_hour, nil, nil, "+09:00")
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
    end_time: end_time,
    status: "active",
  )
  info[:image_urls].each do |image_url|
    puts "Opening... #{image_url}"
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
