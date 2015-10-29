
require "./test/test_helper"

class GithubPresenterTest < ActiveSupport::TestCase
  attr_reader :service, :user

  def setup
    @user ||= User.find_or_create_by(
         nickname: "adamki",
         uid: "10334352",
         oauth_token: ENV["USER_TOKEN"],
         email: "adajensen@gmail.com",
         image_url: "https://avatars.githubusercontent.com/u/10334352?v=3",
    )
    @service ||= GithubPresenter.new(user)
  end

end
