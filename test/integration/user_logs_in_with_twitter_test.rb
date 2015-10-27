require 'test_helper'

class UserLogsInWithGithubTest < ActionDispatch::IntegrationTest
  include Capybara::DSL

  def setup
    Capybara.app = GitCurious::Application
    stub_omniauth
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
