module SilentPostgres
  def self.init!
    ActiveRecord::ConnectionAdapters::PostgreSQLAdapter.send(:include, SilentPostgres)
  rescue NameError
  end

  if defined?(Rails::Railtie)
    # Rails 3
    class Railtie < Rails::Railtie
      initializer 'silent_postgres.insert_into_active_record' do
        ActiveSupport.on_load :active_record do
          SilentPostgres.init!
        end
      end
    end
  else
    # Rails 2
    init!
  end
end
