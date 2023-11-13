# frozen_string_literal: true

require_relative "lib/bridgetown_jam_comments/version"

Gem::Specification.new do |spec|
  spec.name             = "bridgetown_jam_comments"
  spec.version          = JamComments::VERSION
  spec.authors          = ["Alex MacArthur"]
  spec.email            = ["alex@macarthur.me"]
  spec.summary          = "A Bridgetown plugin for setting up JamComments in a Bridgetown site."
  spec.homepage         = "https://github.com/alexmacarthur/bridgetown-jam-comments"
  spec.license          = "MIT"

  spec.files            = Dir["lib/**/*"]
  spec.extra_rdoc_files = Dir["README.md", "LICENSE.txt"]
  spec.require_paths    = ["lib"]

  spec.required_ruby_version = ">= 2.7.2"

  spec.add_runtime_dependency "bridgetown"
  spec.add_runtime_dependency "httparty"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "rubocop-bridgetown"
  spec.metadata["rubygems_mfa_required"] = "true"
end
