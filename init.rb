if %w(test development).include?(ENV["RAILS_ENV"])
  puts "Silencing Postgres"
  require 'silent_postgres'
  ActiveRecord::ConnectionAdapters::PostgreSQLAdapter.send(:include, SilentPostgres)
end