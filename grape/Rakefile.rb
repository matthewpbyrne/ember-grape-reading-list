require 'rake/testtask'
require 'yaml'

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/**/test*.rb']
  t.verbose = true
end

namespace :db do
  desc "Run migrations"
  task :migrate, [:env,:version] do |t, args|
    require "sequel"
    Sequel.extension :migration
    
    db_config = YAML.load_file('config/database.yml')
    env = args[:env]
    env = 'development' unless db_config.keys.include? env
    db_name = db_config[env]['database']
    db = Sequel.connect("sqlite://#{db_name}")
    
    if args[:version]
      puts "Migrating to version #{args[:version]}"
      Sequel::Migrator.run(db, "db/migrations", target: args[:version].to_i)
    else
      puts "Migrating to latest"
      Sequel::Migrator.run(db, "db/migrations")
    end
  end
end
