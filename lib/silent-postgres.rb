if Rails.env.development? || Rails.env.test?

  require "silent-postgres/railtie"
  require "silent-postgres/schema_plus"

  module SilentPostgres
    SILENCED_METHODS = %w(tables table_exists? indexes column_definitions pk_and_sequence_for last_insert_id)

    def self.included(base)
      SILENCED_METHODS.each do |m|
        base.send :alias_method, "#{m}_without_silencer", m
        base.send :alias_method, m, "#{m}_with_silencer"
      end
    end

    SILENCED_METHODS.each do |m|
      m1, m2 = if m =~ /^(.*)\?$/
                 [$1, '?']
               else
                 [m, nil]
      end

      eval <<-METHOD
        def #{m1}_with_silencer#{m2}(*args)
          @logger.silence do
            #{m1}_without_silencer#{m2}(*args)
          end
        end
      METHOD
    end
  end

end

