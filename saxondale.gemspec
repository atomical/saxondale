$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'saxondale/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'saxondale'
  s.version     = Saxondale::VERSION
  s.authors     = ['Adam Hallett']
  s.email       = ['adam.t.hallett@gmail.com']
  s.homepage    = 'https://github.com/atomical/saxondale'
  s.summary     = 'ETags for ActiveFedora datastreams.'
  s.description = 'ETags for ActiveFedora datastreams.'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'rails', '~> 3.2.3'
  s.add_dependency 'active-fedora'

  s.add_development_dependency 'rails', '~> 3.2.3'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'debugger'
  s.add_development_dependency 'activemodel'

end
