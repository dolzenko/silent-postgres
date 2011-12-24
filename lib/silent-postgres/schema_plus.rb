module SilentPostgresSchemaPlus
  SILENCED_METHODS = %w(indexes foreign_keys reverse_foreign_keys views view_definition)

  def self.included(base)
    SILENCED_METHODS.each do |m|
      base.send :alias_method_chain, m, :silencer
    end
  end

  SILENCED_METHODS.each do |m|
    eval <<-METHOD
      def #{m}_with_silencer(*args)
        @logger.silence do
          #{m}_without_silencer(*args)
        end
      end
    METHOD
  end
end

begin
  require "schema_plus/active_record/connection_adapters/postgresql_adapter"
  if defined?(SchemaPlus::ActiveRecord::ConnectionAdapters::PostgresqlAdapter)
    SchemaPlus::ActiveRecord::ConnectionAdapters::PostgresqlAdapter.send(:include, SilentPostgresSchemaPlus)
  end
rescue LoadError
  # do nothing
end
