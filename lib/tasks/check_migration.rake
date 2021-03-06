namespace :db do
  task check_migration: [:environment] do
    begin
      version = ENV["VERSION"] ||
        ActiveRecord::Migrator.migrations(ActiveRecord::Migrator.migrations_paths).map(&:version).sort.last
      if Ania::Checker.new(version).check!
        puts "Rails and SQL migrations match! Congratulations"
      end
    rescue Ania::MigrationMismatch => ex
      puts "Rails and SQL migrations produced different results"
      puts ex.message
    end
  end
end
