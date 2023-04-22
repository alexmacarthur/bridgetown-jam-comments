# frozen_string_literal: true

require_relative "./service"
require_relative "./renderer"
require_relative "./configuration"

module JamComments
  class Builder < Bridgetown::Builder
    def build
      liquid_tag :jam_comments, :render
    end

    private

    def render(attributes, tag)
      Renderer.new(config.bridgetown_jam_comments).render(attributes, tag)
    end
  end
end
