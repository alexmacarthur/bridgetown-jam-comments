# frozen_string_literal: true

require "bridgetown"
require_relative "./bridgetown_jam_comments/builder"

Bridgetown.initializer :bridgetown_jam_comments do |config, domain: nil, api_key: nil, base_url: nil, environment: nil|
  config.bridgetown_jam_comments ||= {}
  config.bridgetown_jam_comments[:domain] = config.bridgetown_jam_comments.domain || domain
  config.bridgetown_jam_comments[:api_key] = config.bridgetown_jam_comments.api_key || api_key
  config.bridgetown_jam_comments[:base_url] = config.bridgetown_jam_comments.base_url || base_url
  config.bridgetown_jam_comments[:environment] =
    config.bridgetown_jam_comments.environment || environment

  config.builder JamComments::Builder
end
