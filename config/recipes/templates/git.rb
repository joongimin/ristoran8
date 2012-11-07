namespace :git do
  desc "Install latest stable release of git"
  task :install, :roles => :web do
    run "#{sudo} apt-get -y install git-core"
  end
  after "deploy:install", "git:install"
end