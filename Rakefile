
namespace :db do

	desc "Run migrations"
  task :migrate, [:version] do |t, args|
    require "sequel"
    Sequel.extension :migration
    db = ENV["DATABASE_URL"] ? Sequel.connect(ENV["DATABASE_URL"]) : Sequel.sqlite('db.sqlite3')
    if args[:version]
      puts "Migrating to version #{args[:version]}"
      Sequel::Migrator.run(db, "db/migrations", target: args[:version].to_i)
    else
      puts "Migrating to latest"
      Sequel::Migrator.run(db, "db/migrations")
    end
  end

	# rake db:migrate
	# rake db:migrate[42]

end
