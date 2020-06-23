lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "hyperwallet/version"

Gem::Specification.new do |s|
  s.name          = "hyperwallet-ruby"
  s.version       = Hyperwallet::VERSION
  s.authors       = ["Jordán Treviño"]
  s.email         = ["jordan@teloslabs.co"]

  s.summary       = "Provides a Ruby wrapper for Hyperwallet's API "
  s.homepage      = "https://github.com/TelosLabs/hyperwallet-ruby"
  s.license       = "MIT"

  s.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  s.metadata["homepage_uri"]    = s.homepage
  s.metadata["source_code_uri"] = "https://github.com/TelosLabs/hyperwallet-ruby"
  s.metadata["changelog_uri"]   = "https://github.com/TelosLabs/hyperwallet-ruby/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  s.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  s.bindir        = "exe"
  s.executables   = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "bundler", "~> 2.0"
  s.add_development_dependency "rake", "~> 10.0"
  s.add_development_dependency "rspec", "~> 3.0"
  s.add_development_dependency("faraday")
end
