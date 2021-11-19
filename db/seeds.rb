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
  30.times do
    file = URI.open('https://thispersondoesnotexist.com/image')
    user = User.create!(
      email: Faker::Internet.safe_email,
      password: '123123',
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name
    )
    user.photo.attach(io: file, filename: 'user.png', content_type: 'image/png')
  end
  puts "...Created #{User.count} users"
end

puts "Cleaning up experiences and bookings..."
Booking.destroy_all
Experience.destroy_all
puts "...done"

puts "Creating experiences..."
experiences = {
  'Russian Roulette' => { image_url: 'https://d4r15a7jvr7vs.cloudfront.net/ewoJICAgICAgICAgICAgICAgICJidWNrZXQiOiAiZmlsZXMubGJyLmNsb3VkIiwKCSAgICAgICAgICAgICAgICAia2V5IjogInB1YmxpYy93a29pMWx4aTlkbzRwNm5yb2J4OC5qcGciLAoJICAgICAgICAgICAgICAgICJlZGl0cyI6IHsKCSAgICAgICAgICAgICAgICAgICJyZXNpemUiOiB7CgkgICAgICAgICAgICAgICAgICAgICJ3aWR0aCI6IDk0NSwKCSAgICAgICAgICAgICAgICAgICAgImhlaWdodCI6IDUyNiwKCSAgICAgICAgICAgICAgICAgICAgImZpdCI6ICJjb3ZlciIKCSAgICAgICAgICAgICAgICAgIH0KCSAgICAgICAgICAgICAgICB9CgkgICAgICAgICAgICB9' },
  'Lying on Train Tracks' => { image_url: 'https://d2gg9evh47fn9z.cloudfront.net/800px_COLOURBOX2198605.jpg' },
  'Cliff Jumping' => { image_url: 'https://img1.10bestmedia.com/Images/Photos/317046/photo_54_990x660.jpg' },
  'Blindfold Driving' => { image_url: 'https://www.nottinghamoffroadevents.co.uk/_webedit/cached-images/331-0-0-0-10000-10000-536.jpg' },
  'Jetskiing with Sharks' => { image_url: 'https://img.redbull.com/images/c_crop,x_0,y_0,h_2848,w_3164/c_fill,w_860,h_782/q_auto,f_auto/redbullcom/2018/07/06/c8eb4913-6df0-4bd7-b6e9-4f24f02c0e81/jetskiing-collection' },
  'Swimming with Alligators' => { image_url: 'https://www.hola.com/us/images/025e-0f96b9f13dd6-18f93d88afaf-1000/square-800/gator.jpg' },
  'Hippo Rodeo' => { image_url: 'https://cdn.hswstatic.com/gif/hippo-sunscreen.jpg' },
  'Mountain Biking Everest' => { image_url: 'https://i.dailymail.co.uk/i/pix/2012/06/17/article-2160665-13A64880000005DC-860_634x416.jpg' },
  'Helicopter Obstacle Course' => { image_url: 'https://corporatehelicopters.b-cdn.net/wp-content/uploads/america-sailing-cup-720x480.jpg' },
  'Highway Car Jumping' => { image_url: 'https://media.gq.com/photos/55828968e52bc4b477a972b1/1:1/w_450,h_450,c_limit/blogs-the-feed-man-jumps-from-car-635.jpg' }
}
prices = [500, 1000, 1500, 2000, 2500, 3000]

experiences.each do |name, info|
  experience = Experience.create!(
    name: name,
    description: Faker::Lorem.paragraph,
    price: prices.sample,
    address: Faker::Address.street_address,
    latitude: Faker::Address.latitude,
    longitude: Faker::Address.longitude,
    user: User.all.sample
  )
  file = URI.open(info[:image_url])
  experience.photos.attach(io: file, filename: 'experience.png', content_type: 'image/png')
end
puts "Created #{Experience.count} experiences..."

puts "Creating 2 bookings for each user"
User.find_each do |user|
  experiences = Experience.all.sample(2)
  experiences.each do |experience|

  end
  booking = Booking.new(
    user: user,
    experience: Experience.all.sample,
    start_time: DateTime.now + rand(5..15).days
  )
  booking.end_time = booking.start_time + rand(1..3).hours
  booking.save!

  booking = Booking.new(
    user: user,
    experience: Experience.all.sample,
    start_time: DateTime.now + rand(5..15).days
  )
  booking.end_time = booking.start_time + rand(1..3).hours
  booking.save!
end
puts "Created #{Booking.count} bookings..."
