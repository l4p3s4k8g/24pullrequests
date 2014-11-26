namespace :humans do
  desc 'Update contributors in humans.txt'
  task :update => :environment do
    unless Rails.env.production?
      puts 'Cannot run task, must be in production'
    else
      header = <<-eos
/* IDEA */

Andrew Nesbitt
GitHub Profile: https://github.com/andrew
Location: Bath, UK
Website: http://nesbitt.io

/* CONTRIBUTORS */

      eos

      humans_txt = File.open("#{Rails.root}/app/views/static/humans.txt", 'w')
      humans_txt.puts header

      Rails.application.config.contributors.map(&:login).each do |login|
        next if login.eql?('andrew')

        Timeout::timeout(5) {
          gh_user = Octokit.user(login)
        }

        humans_txt.puts gh_user.name.nil? ? login : gh_user.name
        humans_txt.puts "GitHub Profile: #{gh_user.html_url}"
        humans_txt.puts "Location: #{gh_user.location}" if gh_user.location
        humans_txt.puts "Website: #{gh_user.blog}\n\n" if gh_user.blog
      end

      humans_txt.close
    end
  end
end
