require "./test/test_helper"

class GithubServiceTest < ActiveSupport::TestCase
  attr_reader :service, :user

  def setup
    @user = User.create!(
         id: 1,
         nickname: "adamki",
         uid: "10334352",
         oauth_token: ENV["CLIENT_ID"],
         email: "adajensen@gmail.com",
         image_url: "https://avatars.githubusercontent.com/u/10334352?v=3",
         followers: "4",
         following: "19"
    )
    @service ||= GithubService.new(user)
  end

  test "#find_user_followers" do
    VCR.use_cassette('github#find_user_followers_test') do
      followers = service.find_user_followers(user)
      follower  = followers.first

      assert_equal 4, followers.count
    end
  end
end
