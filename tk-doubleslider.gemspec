# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tk/doubleslider/version'

Gem::Specification.new do |spec|
	spec.name          = "tk-doubleslider"
	spec.version       = Tk::Doubleslider::VERSION
	spec.authors       = ["chrislee35"]
	spec.email         = ["rubygems@chrislee.dhs.org"]
	spec.description   = %q{This provides an advanced, double-headed slider widget that allows selection of a range of values on a linear, log, square root, or cube root axis.}
	spec.summary       = %q{A double headed slider widget for Tk}
	spec.homepage      = "https://rubygems.org/gems/tk-doubleslider"
	spec.license       = "MIT"

	spec.files         = `git ls-files`.split($/)
	spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
	spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
	spec.require_paths = ["lib"]

	spec.add_development_dependency "bundler", "~> 1.3"
	spec.add_development_dependency "rake"
	
	#spec.add_runtime_dependency "tk"
	
	spec.test_files       = `git ls-files -- {test,spec,features}/*`.split("\n")
end
