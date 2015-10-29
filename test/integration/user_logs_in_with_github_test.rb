require_relative '../test_helper'

class UserLogsInWithGithubTest < ActionDispatch::IntegrationTest
  include Capybara::DSL

  def setup
    Capybara.app = GitCurious::Application
    stub_omniauth
  end

  def stub_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      uid: "10334352",
      info: {
        nickname: "adamki",
        email: "adajensen@gmail.com",
        image: "https://avatars.githubusercontent.com/u/10334352?v=3"
      },
      credentials:{
        oauth_token: "3df3249c5f371b4d58619f78855f479d244608c2"
      }
    })
  end

  test "logging in" do
    skip
    VCR.use_cassette('user#log_in') do
      visit "/"
      assert_equal 200, page.status_code
      assert page.has_content?("git-curious")
      click_link("Login with Github")
    end
  end
end
