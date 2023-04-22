# frozen_string_literal: true

describe JamComments::Renderer do
  let(:subject) do
    described_class.new({
      "domain"      => "example.com",
      "api_key"     => "abc123",
      "base_url"    => nil,
      "environment" => nil,
    })
  end

  describe("#render") do
    it("renders correctly") do
      allow_any_instance_of(JamComments::Service)
        .to receive(:fetch)
        .with(path: "/path")
        .and_return("<div>test markup</div>")

      rendered = subject.render(
        {},
        OpenStruct.new(context: OpenStruct.new(page: OpenStruct.new(relative_url: "/path")))
      )

      expect(rendered).to include("<div>test markup</div>")
      expect(rendered).to match(%r!<script src="https://unpkg\.com/@jam-comments/client@(.*)/dist/index\.umd\.js"></script>!)
    end
  end
end
