Gem::Specification.new do |s|
  s.name = 'bag_of_holding'
  s.version = '0.0.2'
  s.platform = Gem::Platform::RUBY
  s.authors = ['Evan Sharp']
  s.license = 'MIT'
  s.summary = 'Utilities for your tabletop gaming needs'
  s.require_path = 'lib'
  s.homepage = 'https://github.com/packetmonkey/bag_of_holding'
  s.executables << 'boh'
  s.required_ruby_version = '~> 2.1'

  s.add_dependency 'parslet', '>= 1.6', '< 2.0'
  s.add_dependency 'thor', '>= 0.19.1', '< 2.0'

  s.add_development_dependency 'rubocop', '0.28.0'
  s.add_development_dependency 'rake', '0.9.6'
  s.add_development_dependency 'rspec', '~> 3.1'
  s.add_development_dependency 'pry', '0.10.1'
  s.add_development_dependency 'flog', '~> 4.0'

  s.files = Dir.glob('{lib,spec}/**/*') + %w(README.md Rakefile)
end
