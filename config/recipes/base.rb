def template(from, to, args = {})
  erb = File.read(File.expand_path("../templates/#{from}", __FILE__))
  if args[:use_temp_file]
    temp_file = "/tmp/#{from}-#{Time.now.to_i}"
    put ERB.new(erb).result(binding), temp_file
    run "#{sudo} mv #{temp_file} #{to}"
  else
    put ERB.new(erb).result(binding), to
  end
end

def set_default(name, *args, &block)
  set(name, *args, &block) unless exists?(name)
end

namespace :deploy do
  desc "Install everything onto the server"
  task :install do
    run "#{sudo} mkdir -p /mnt/#{application}"
    run "#{sudo} chown #{user}:#{user} /mnt/#{application}"
    run "#{sudo} ln -nsf /mnt/#{application} /home/#{user}/#{application}"

    # Update & Upgrade Ubuntu
    run "#{sudo} apt-get -y update"
    run "#{sudo} apt-get -y upgrade"

    # Nokogiri
    run "#{sudo} apt-get -y install libxslt1-dev libxml2-dev"

    # Mysql 
    run "#{sudo} apt-get -y install libmysqlclient-dev"

    # Curb
    run "#{sudo} apt-get -y install libcurl4-openssl-dev"

    # RMagick
    run "#{sudo} apt-get -y install libmagickwand-dev"
  end
end