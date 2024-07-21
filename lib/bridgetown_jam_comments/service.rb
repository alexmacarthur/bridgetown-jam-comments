# frozen_string_literal: true

require "httparty"

module JamComments
  class Service
    attr_reader :base_url, :tz, :environment, :domain, :api_key, :client, :copy

    def initialize(
      domain:,
      api_key:,
      base_url: nil,
      environment: nil,
      tz: nil,
      copy: {},
      client: HTTParty
    )
      @tz = tz
      @copy = copy
      @client = client
      @domain = domain
      @api_key = api_key
      @base_url = base_url || "https://go.jamcomments.com"
      @environment = environment || "production"
    end

    def fetch(path:)
      options = {
        query: request_query_params(path),
        headers: {
          Authorization: "Bearer #{api_key}",
          Accept: "application/json",
          "X-Platform": "bridgetown",
        },
      }

      send_request(options)
    end

    private

    def request_query_params(path)
      {
        path: formatted_path(path),
        domain: domain,
        stub: stub_value,
        tz: tz,
      }.merge(copy)
    end

    def send_request(options)
      response = client.get(endpoint, options)

      raise "Oh no! It looks like your credentials for JamComments are incorrect." if response.code == 401

      raise "Oh no! JamComments request failed. Please try again. Status: #{response.code}" if response.code != 200

      response.body
    end

    def stub_value
      return "true" if environment != "production"

      nil
    end

    def endpoint
      "#{base_url}/api/v3/markup"
    end

    def formatted_path(path)
      path.empty? ? "/" : path
    end
  end
end
