require 'test_helper'

class UserLogsInWithGithubTest < ActionDispatch::IntegrationTest

  include Capybara::DSL

  def setup
    Capybara.app = GitCurious::Application
    stub_omniauth
  end

  def stub_omniauth

    # first, set OmniAuth to run in test mode
    OmniAuth.config.test_mode = true
    # then, provide a set of fake oauth data that
    # omniauth will use when a user tries to authenticate:
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      uid: "1234",
      info: {
        nickname: "Larry",
        email: "larry@test.com"
      },
      credentials: {
        token: "iLovePerl"
      }
    })
  end

  test "logging in" do
    visit "/"
    assert_equal 200, page.status_code
    click_link "Login with Github"
    assert_equal "/", current_path
    assert page.has_content?("Larry")
    assert page.has_link?("Logout")
  end
end
