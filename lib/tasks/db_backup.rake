namespace :db do
  desc "Backup the production database"
  task :backup => :environment do
    backup_dir = ENV['DIR'] || File.join(Rails.root, 'db', 'backup')
    makedirs backup_dir, verbose: true

    source = File.join(Rails.root, 'db', 'production.db')
    dest = File.join(backup_dir, 'production.backup')

    require 'shellwords'
    sh "sqlite3 #{Shellwords.escape source} .dump > #{Shellwords.escape dest}"
  end
end
