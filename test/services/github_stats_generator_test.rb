require "./test/test_helper"

class GithubStatsGeneratorTest < ActiveSupport::TestCase
  attr_reader :stats, :user

  def setup
    @user ||= User.find_or_create_by(
         nickname: "adamki",
         uid: "10334352",
         oauth_token: ENV["USER_TOKEN"],
         email: "adajensen@gmail.com",
         image_url: "https://avatars.githubusercontent.com/u/10334352?v=3",
    )
    @stats ||= GithubStatsGenerator.new(user)
  end

  test "#annual_contributions_test" do
    VCR.use_cassette('github_stats_generator#annual_contributions') do
      annual_contributions = stats.annual_contributions
      first_contribution = annual_contributions
      assert_equal Fixnum,first_contribution.class
    end
  end

  test "#longest_streak" do
    VCR.use_cassette('github_stats_generator#longest_streak') do
      longest_streak = stats.longest_streak
      assert_equal 22, longest_streak
    end
  end

  test "#current_streak" do
    VCR.use_cassette('github_stats_generator#current_streak') do
      current_streak = stats.current_streak
      assert_equal Fixnum, current_streak.class
    end
  end
end
