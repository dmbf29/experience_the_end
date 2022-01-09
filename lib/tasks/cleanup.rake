namespace :cleanup do
  desc "removes stale and inactive products from the database"
  task :experiences => :environment do
    # Find all the products older than yesterday, that are not active yet
    stale_experiences = Experience.where("DATE(created_at) < DATE(?)", Date.yesterday).where("status is not 'active'")

    # delete them
    stale_experiences.map(&:destroy)
  end
end