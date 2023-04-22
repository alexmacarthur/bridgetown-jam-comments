# frozen_string_literal: true

module JamComments
  class Configuration
    attr_reader :config

    def initialize(config)
      @config = config
    end

    def domain
      config["domain"] || ENV.fetch("JAM_COMMENTS_DOMAIN", nil)
    end

    def base_url
      config["base_url"] || ENV.fetch("JAM_COMMENTS_BASE_URL", nil)
    end

    def api_key
      config["api_key"] || ENV.fetch("JAM_COMMENTS_API_KEY", nil)
    end

    def environment
      config["environment"] || ENV["JAM_COMMENTS_ENVIRONMENT"] || ENV.fetch("BRIDGETOWN_ENV", nil)
    end
  end
end
