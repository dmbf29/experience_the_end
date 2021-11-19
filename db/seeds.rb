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
    user = Upload.create!(
      email: Faker::Internet.safe_email,
      password: '123123',
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name
    )
    user.photo.attach(io: file, filename: 'user.png', content_type: 'image/png')
  end
  puts "...Created #{User.count} users"
end


puts "Creating experiences..."
experiences = {
  'Russian Roulette' => ""
  'Lying on Train Tracks' => ""
  'Cliff Jumping' => ""
  'Blindfold Driving' => ""
  'Jetskiing with Sharks' => ""
  'Swimming with Alligators' => ""
  'Hippo Rodeo' => ""
  'Mountain Biking Everest' => ""
  'Helicopter Obstacle Course' => ""
  'Highway Car Jumping' => ""
}
prices = [500, 1000, 1500, 2000, 2500, 3000]

experiences.each do |name, info|
  Experience.create!(
    name: name,
    description: Faker::Lorem.paragraph,
    price: prices.sample
    address: Faker::Address.street_address
    user: User.all.sample
  )
end
