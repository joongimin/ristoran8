set_default(:mysql_host, "localhost")
set_default(:mysql_user) { "nuvo" }
set_default(:mysql_root_password) { "welcome2nv" }
set_default(:mysql_password) { "welcome2nv" }
set_default(:mysql_production_database) { "nouvaux" }
set_default(:mysql_production_host) { "db2.xnuvo.com" }

namespace :mysql do
  desc "Install the latest stable release of MySQL."
  task :install, roles: :db, only: {primary: true} do
    run "#{sudo} apt-get -y install mysql-server" do |channel, stream, data|
      channel.send_data("#{mysql_root_password}\n\r") if data =~ /password/
    end
    template "mysql.cnf.erb", "/etc/mysql/conf.d/#{application}.cnf", :use_temp_file => true
    run "#{sudo} service mysql restart"
  end
  after "deploy:install", "mysql:install"

  desc "Install the latest stable release of MySQL client."
  task :install_client, roles: :db do
    run "#{sudo} apt-get -y install mysql-client"
  end
  after "deploy:install", "mysql:install_client"

  desc "Create a database for this application."
  task :create_database, roles: :db, only: {primary: true} do
    run %Q{mysql -uroot -p#{mysql_password} -e "create database if not exists #{mysql_database}; grant all privileges on #{mysql_database}.* to #{mysql_user}@localhost identified by '#{mysql_password}';"}
  end
  if rails_env == "test"
    after "deploy:setup", "mysql:create_database"
  end

  desc "Generate the database.yml configuration file."
  task :setup, roles: :app do
    run "mkdir -p #{shared_path}/config"
    template "mysql.yml.erb", "#{shared_path}/config/database.yml"
    run "mkdir -p #{shared_path}/backups"
  end
  after "deploy:setup", "mysql:setup"

  desc "Symlink the database.yml file into latest release"
  task :symlink, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
  after "deploy:finalize_update", "mysql:symlink"

  desc "Backup MySQL Database"
  task :backup, :roles => :db do
    run "mysqldump -u#{mysql_user} -p#{mysql_password} #{mysql_database} -h #{mysql_host} > #{shared_path}/backups/#{release_name}.sql"
  end
  after "deploy", "mysql:backup"
  before "deploy:migrate", "mysql:backup"

  desc "Sync database to the production version"
  task :sync, :roles => :db do
    if rails_env == "test" || rails_env == "development"
      set :mysql_dumpfile, Time.now.strftime("%Y%m%d%H%M%S_manual.sql")
      run "mysqldump -u#{mysql_user} -p#{mysql_password} #{mysql_production_database} -h #{mysql_production_host} > #{shared_path}/backups/#{mysql_dumpfile}"
      run %Q{mysql -u#{mysql_user} -p#{mysql_password} -h #{mysql_host} -e "drop database #{mysql_database}; create database #{mysql_database};"}
      run "mysql -u#{mysql_user} -p#{mysql_password} -h #{mysql_host} #{mysql_database} < #{shared_path}/backups/#{mysql_dumpfile}"
    end
  end
end