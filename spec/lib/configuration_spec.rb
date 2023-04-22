# frozen_string_literal: true

describe JamComments::Configuration do
  before(:each) do
    ENV["JAM_COMMENTS_ENVIRONMENT"] = "production"
    ENV["JAM_COMMENTS_DOMAIN"] = "macarthur.me"
    ENV["JAM_COMMENTS_API_KEY"] = "xyz"
    ENV["JAM_COMMENTS_BASE_URL"] = "https://go.jamcomments.com"
  end

  describe("set in config") do
    it("returns correct values") do
      subject = described_class.new({
        "domain"      => "example.com",
        "api_key"     => "abc123",
        "base_url"    => "http://localhost",
        "environment" => "development",
      })

      expect(subject.domain).to eq("example.com")
      expect(subject.base_url).to eq("http://localhost")
      expect(subject.api_key).to eq("abc123")
      expect(subject.environment).to eq("development")
    end
  end

  describe("set in ENV") do
    it("returns correct values") do
      subject = described_class.new({})

      expect(subject.domain).to eq("macarthur.me")
      expect(subject.base_url).to eq("https://go.jamcomments.com")
      expect(subject.api_key).to eq("xyz")
      expect(subject.environment).to eq("production")
    end

    it("falls back to BRIDGETOWN_ENV") do
      subject = described_class.new({})
      ENV["BRIDGETOWN_ENV"] = "bridgetown_env"
      ENV["JAM_COMMENTS_ENVIRONMENT"] = nil

      expect(subject.environment).to eq("bridgetown_env")
    end
  end
end
