# frozen_string_literal: true

require "pry"

module JamComments
  class Renderer
    CLIENT_SCRIPT_URL = "https://unpkg.com/@jam-comments/client@2.3.2/dist/index.umd.js"

    attr_reader :provided_configuration

    def initialize(provided_configuration)
      @provided_configuration = provided_configuration
    end

    def render(_attributes, tag)
      context = tag.context
      path = context["page"] && context["page"]["relative_url"]
      markup = service.fetch(path: path)

      "
        #{markup}
        <script src=\"#{CLIENT_SCRIPT_URL}\"></script>
        <script>
          window.JamComments.initialize();
        </script>
      "
    end

    private

    def configuration
      @configuration ||= Configuration.new(provided_configuration)
    end

    def service
      @service ||= Service.new(
        domain: configuration.domain,
        api_key: configuration.api_key,
        base_url: configuration.base_url,
        environment: configuration.environment
      )
    end
  end
end
