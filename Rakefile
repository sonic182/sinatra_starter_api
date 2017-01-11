
namespace :db do

	desc "Run migrations"
  task :migrate, [:version] do |t, args|
    require "sequel"
    Sequel.extension :migration
		url = ENV['DATABASE_URL']
	  url = RUBY_PLATFORM == 'java' ? url = 'jdbc:' + url : url if url
    db = url ? Sequel.connect(url) : Sequel.sqlite('db.sqlite3')
    if args[:version]
      puts "Migrating to version #{args[:version]}"
      Sequel::Migrator.run(db, "db/migrations", target: args[:version].to_i)
    else
      puts "Migrating to latest"
      Sequel::Migrator.run(db, "db/migrations")
    end
  end

	desc "Get current Schema as a migration in db/schema.rb"
  task :dump do |t|
    require "open3"
		url = 'sqlite://db.sqlite3'
		url = ENV["DATABASE_URL"] ? ENV["DATABASE_URL"] : url

		cmd = "sequel -d #{url} > db/schema.rb"
		stdin, stdout, stderr, wait_thr = Open3.popen3(cmd)
		stdout.gets(nil)
		stdout.close
		stderr.gets(nil)
		stderr.close
		exit_code = wait_thr.value

  end

end
