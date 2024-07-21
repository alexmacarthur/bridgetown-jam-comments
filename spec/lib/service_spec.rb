# frozen_string_literal: true

describe JamComments::Service do
  let(:client) { class_double("client") }

  describe "#fetch" do
    context "production" do
      it "makes correct request" do
        instance = described_class.new(
          domain: "example.com",
          api_key: "abc123",
          client: client
        )

        expect(client).to receive(:get).with(
          "https://go.jamcomments.com/api/v3/markup",
          {
            query: hash_including(
              path: "/path",
              domain: "example.com",
              stub: nil
            ),
            headers: hash_including(
              Authorization: "Bearer abc123",
              Accept: "application/json",
              "X-Platform": "bridgetown"
            ),
          }
        ).and_return(OpenStruct.new(
                       code: 200,
                       body: "html!"
                     ))

        instance.fetch(path: "/path")
      end
    end

    context "development" do
      it "makes correct request" do
        instance = described_class.new(
          base_url: "http://localhost",
          domain: "example.com",
          api_key: "abc123",
          client: client,
          environment: "development"
        )

        expect(client).to receive(:get).with(
          "http://localhost/api/v3/markup",
          {
            query: hash_including(
              path: "/path",
              domain: "example.com",
              stub: "true"
            ),
            headers: hash_including(
              Authorization: "Bearer abc123",
              Accept: "application/json",
              "X-Platform": "bridgetown"
            ),
          }
        ).and_return(OpenStruct.new(
                       code: 200,
                       body: "html!"
                     ))

        instance.fetch(path: "/path")
      end
    end

    context "unauthorized" do
      it "throws exception" do
        instance = described_class.new(
          domain: "example.com",
          api_key: "abc123",
          client: client
        )

        expect(client)
          .to receive(:get)
          .and_return(OpenStruct.new(
                        code: 401,
                        body: "html!"
                      ))

        expect do
          instance.fetch(path: "/path")
        end
          .to raise_error("Oh no! It looks like your credentials for JamComments are incorrect.")
      end
    end

    context "timezone" do
      it "passes tz" do
        instance = described_class.new(
          domain: "example.com",
          api_key: "abc123",
          tz: "America/New_York",
          client: client
        )

        expect(client).to receive(:get).with(
          "https://go.jamcomments.com/api/v3/markup",
          {
            query: hash_including(
              path: "/path",
              domain: "example.com",
              stub: nil,
              tz: "America/New_York"
            ),
            headers: hash_including(
              Authorization: "Bearer abc123",
              Accept: "application/json",
              "X-Platform": "bridgetown"
            ),
          }
        ).and_return(OpenStruct.new(
                       code: 200,
                       body: "html!"
                     ))

        instance.fetch(path: "/path")
      end
    end

    context "other error" do
      it "throws exception" do
        instance = described_class.new(
          domain: "example.com",
          api_key: "abc123",
          client: client
        )

        expect(client)
          .to receive(:get)
          .and_return(OpenStruct.new(
                        code: 500,
                        body: "html!"
                      ))

        expect do
          instance.fetch(path: "/path")
        end
          .to raise_error("Oh no! JamComments request failed. Please try again. Status: 500")
      end
    end
  end

  context "custom copy" do
    it "passes copy" do
      instance = described_class.new(
        domain: "example.com",
        api_key: "abc123",
        copy: {
          copy_confirmation_message: "Thanks for commenting!",
          copy_submit_button: "Post",
          copy_name_placeholder: "Name",
          copy_email_placeholder: "Email",
          copy_comment_placeholder: "Comment",
          copy_write_tab: "Write",
          copy_preview_tab: "Preview",
          copy_auth_button: "Log in",
          copy_log_out_button: "Log out",
        },
        client: client
      )

      expect(client).to receive(:get).with(
        "https://go.jamcomments.com/api/v3/markup",
        {
          query: hash_including(
            path: "/path",
            domain: "example.com",
            stub: nil,
            copy_confirmation_message: "Thanks for commenting!",
            copy_submit_button: "Post",
            copy_name_placeholder: "Name",
            copy_email_placeholder: "Email",
            copy_comment_placeholder: "Comment",
            copy_write_tab: "Write",
            copy_preview_tab: "Preview",
            copy_auth_button: "Log in",
            copy_log_out_button: "Log out"
          ),
          headers: hash_including(
            Authorization: "Bearer abc123",
            Accept: "application/json",
            "X-Platform": "bridgetown"
          ),
        }
      ).and_return(OpenStruct.new(
                     code: 200,
                     body: "html!"
                   ))

      instance.fetch(path: "/path")
    end

    it "passes only some copy" do
      instance = described_class.new(
        domain: "example.com",
        api_key: "abc123",
        copy: {
          copy_confirmation_message: "Thanks for commenting!",
          copy_submit_button: "Post",
        },
        client: client
      )

      expect(client).to receive(:get).with(
        "https://go.jamcomments.com/api/v3/markup",
        {
          query: hash_including(
            path: "/path",
            domain: "example.com",
            stub: nil,
            copy_confirmation_message: "Thanks for commenting!",
            copy_submit_button: "Post"
          ),
          headers: hash_including(
            Authorization: "Bearer abc123",
            Accept: "application/json",
            "X-Platform": "bridgetown"
          ),
        }
      ).and_return(OpenStruct.new(
                     code: 200,
                     body: "html!"
                   ))

      instance.fetch(path: "/path")
    end
  end
end
