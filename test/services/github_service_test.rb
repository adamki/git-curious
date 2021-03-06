require "./test/test_helper"

class GithubServiceTest < ActiveSupport::TestCase
  attr_reader :service, :user

  def setup
    @user ||= User.find_or_create_by(
         nickname: "adamki",
         uid: "10334352",
         oauth_token: ENV["USER_TOKEN"],
         email: "adajensen@gmail.com",
         image_url: "https://avatars.githubusercontent.com/u/10334352?v=3",
    )
    @service ||= GithubService.new(user)
  end

  test "#find_user_repos test" do
    VCR.use_cassette('github_service#find_user_repos_test') do
      repos = service.find_user_repos(user)
      repo  = repos.first
      assert_equal 30, repos.count
    end
  end

  test "find_user_followers_count test" do
    VCR.use_cassette('github_service#find_user_followers_test') do
      followers = service.find_user_followers(user)
      follower  = followers.first
      assert_equal 4, followers.count
    end
  end

  test 'find_users_followees_test' do
    VCR.use_cassette('github_service#find_user_following') do
      following = service.find_user_following(user)
      assert_equal 19, following.count
    end
  end

  test 'find_users_organizations_test' do
    VCR.use_cassette('github_service#find_user_following') do
      organization = service.find_user_organizations(user)
      assert_equal 0, organization.count
    end
  end

  test 'find_user_test' do
    VCR.use_cassette("github_service#find_user") do
      user = service.find_user("adamki")
      assert_equal "adamki", user[:login]
      assert_equal "adajensen@gmail.com", user[:email]
      assert_equal 10334352, user[:id]
    end
  end
end
