# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "normalize_digits/version"

Gem::Specification.new do |spec|
  spec.name = "normalize_digits"
  spec.version = NormalizeDigits::VERSION
  spec.authors = ["aalyahya"]
  spec.email = ["abdullah@alyahya.cc"]

  spec.summary = "Non-English digits converter for ActiveModel attributes"
  spec.description = "An ActiveModel extension that automatically converts all non-English digits to English digits " \
      "before validation. https://github.com/aalyahya/normalize_digits"
  spec.homepage = "https://github.com/aalyahya/normalize_digits"
  spec.license = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.test_files = `git ls-files -- {test,spec}/*`.split("\n")
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "activemodel", ">= 3.0", "< 9.0"
  spec.add_development_dependency "active_attr", "~> 0.17.1"
  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec-rails", "~> 7.1.0"
  spec.add_development_dependency "rubocop-rails-omakase", "~> 1.0.0"

  spec.required_ruby_version = ">= 2.7"
end
