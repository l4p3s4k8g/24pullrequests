namespace :coderwall do
  desc 'Register coderwall awards'
  task :awards => :environment do
    User.all.each(&:award_coderwall_badges)
  end
end
