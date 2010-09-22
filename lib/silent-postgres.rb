module SilentPostgres
  SILENCED_METHODS = %w(tables indexes column_definitions pk_and_sequence_for last_insert_id)

  def self.included(base)
    SILENCED_METHODS.each do |m|
      base.send :alias_method_chain, m, :silencer
    end
  end
  
  SILENCED_METHODS.each do |m|
    eval <<METHOD
      def #{m}_with_silencer(*args)
        @logger.silence do
          #{m}_without_silencer(*args)
        end
      end
METHOD
  end
end

if %w(test development).include?(ENV["RAILS_ENV"])
  puts "Silencing Postgres"
  ActiveRecord::ConnectionAdapters::PostgreSQLAdapter.send(:include, SilentPostgres)
end
