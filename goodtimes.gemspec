# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'goodtimes/version'

Gem::Specification.new do |gem|
  gem.name          = "goodtimes"
  gem.version       = Goodtimes::VERSION
  gem.authors       = ["C. Jason Harrelson (midas)"]
  gem.email         = ["jason@lookforwardenterprises.com"]
  gem.description   = %q{Tools for formatting date and time}
  gem.summary       = %q{Tools for formatting date and time, including some Activerecord extensions.}
  gem.homepage      = "https://github.com/ninja-loss/goodtimes"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
