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

  describe("copy") do
    it("returns correct values") do
      subject = described_class.new({
        "copy" => {
          "confirmation_message" => "Thanks for the comment!",
          "submit_button"        => "Post Comment",
          "name_placeholder"     => "Your Name",
          "email_placeholder"    => "Your Email",
          "comment_placeholder"  => "Your Comment",
          "write_tab"            => "Write",
          "preview_tab"          => "Preview",
          "auth_button"          => "Log In",
          "log_out_button"       => "Log Out",
        },
      })

      expect(subject.copy).to eq({
        copy_confirmation_message: "Thanks for the comment!",
        copy_submit_button: "Post Comment",
        copy_name_placeholder: "Your Name",
        copy_email_placeholder: "Your Email",
        copy_comment_placeholder: "Your Comment",
        copy_write_tab: "Write",
        copy_preview_tab: "Preview",
        copy_auth_button: "Log In",
        copy_log_out_button: "Log Out",
      })
    end

    it("returns nil for missing keys") do
      subject = described_class.new({})

      expect(subject.copy).to eq({})
    end
  end
end
