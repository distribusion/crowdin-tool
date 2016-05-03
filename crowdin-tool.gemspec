# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'crowdin/tool/version'

Gem::Specification.new do |spec|
  spec.name          = "crowdin-tool"
  spec.version       = Crowdin::Tool::VERSION
  spec.authors       = ["jan.rietema\n"]
  spec.email         = ["jan.rietema@distribusion.com"]

  spec.summary       = %q{Command line tool that implements convenient git branch conventions for crowdin-cli commands}
  spec.description   = %q{Adds a 'translation' command for wrapping calls to crowdin-cli, handling git topic branches and master branches automatically.}
  spec.homepage      = "https://github.com/distribusion/crowdin-tool"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_dependency "crowdin-cli"
end
