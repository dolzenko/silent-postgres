# coding: utf-8

Gem::Specification.new do |s|
  s.name = %q{silent-postgres}
  s.version = "0.1.0"
  s.summary = %q{Rails plugin that silences Postgresql connection adapter verbose output}
  s.email = ['bragi@ragnarson.com', 'dolzenko@gmail.com']
  s.homepage = %q{http://github.com/dolzenko/silent-postgres}
  s.authors = ["Łukasz Piestrzeniewicz", "Evgeniy Dolzhenko"]
  s.files = ["MIT-LICENSE", "README", "lib", "silent-postgres.gemspec", "lib/silent-postgres", "lib/silent-postgres/railtie.rb", "lib/silent-postgres.rb", "init.rb"]
end
