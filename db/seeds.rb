puts 'Getting Admin users...'
doug = User.find_by(email: 'douglasmberkley@gmail.com') || User.create(email: 'douglasmberkley@gmail.com', password: ENV['ADMIN_PASSWORD'], admin: true)
trouni = User.find_by(email: 'trouni@gmail.com') || User.create(email: 'trouni@gmail.com', password: ENV['ADMIN_PASSWORD'], admin: true)
sasha = User.find_by(email: 'sasha.kaverina@gmail.com') || User.create(email: 'sasha.kaverina@gmail.com', password: ENV['ADMIN_PASSWORD'], admin: true)
yann = User.find_by(email: 'yann.luc.klein@gmail.com') || User.create(email: 'yann.luc.klein@gmail.com', password: ENV['ADMIN_PASSWORD'], admin: true)
derek = User.find_by(email: 'derek.n.torres@gmail.com') || User.create(email: 'derek.n.torres@gmail.com', password: ENV['ADMIN_PASSWORD'], admin: true)
noemi = User.find_by(email: 'noemi.calanducci@gmail.com') || User.create(email: 'trouni@gmail.com', password: ENV['ADMIN_PASSWORD'], admin: true)
