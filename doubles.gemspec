# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'doubles/version'

Gem::Specification.new do |gem|
  gem.name          = 'doubles'
  gem.version       = Doubles::VERSION
  gem.authors       = ['Nigel Rausch']
  gem.email         = ['nigelr@brisbanerails.com']
  gem.description   = %q{Inteligently converts all double to single quotes}
  gem.summary       = %q{Converts all non-interpolated quotes to single quotes}
  gem.homepage      = 'https://github.com/nigelr/doubles'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ['lib']

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'rake'

end
