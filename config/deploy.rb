set :rails_env, ENV["RAILS_ENV"] || "production"
set :application, "ristoran8"
set :user, "ubuntu"
set :use_sudo, false
set :deploy_to, "/home/#{user}/#{application}"
set :scm, :git
set :branch, "master"
set :repository,  "git@github.com:joongimin/ristoran8.git"
set :deploy_via, :remote_cache
set :normalize_asset_timestamps, false
set :whenever_command, "bundle exec whenever"
set :maintenance_template_path, File.expand_path("../recipes/templates/maintenance.html.erb", __FILE__)

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

set :root_url, "ristoran8.com"
set :mysql_database, "ristoran8"
set :mysql_host, "localhost"
server "w1.ristoran8.com", :app, :web, :db, :primary => true

require "bundler/capistrano"

load "config/recipes/base"
load "config/recipes/git"
load "config/recipes/nginx"
load "config/recipes/unicorn"
load "config/recipes/rbenv"
load "config/recipes/mysql"
load "deploy/assets"

after "deploy:update_code", "deploy:migrate"
after "deploy", "deploy:cleanup" # keep only the last 5 releases