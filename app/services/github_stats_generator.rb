class GithubStatsGenerator
  attr_reader :user, :github_stats

  def initialize(user)
    @user = user
    @github_stats = GithubStats.new(user.nickname)
  end

  def annual_contributions
    @github_stats.data.scores.reduce(:+)
  end

  def longest_streak
    @github_stats.data.longest_streak.count
  end

  def current_streak
    @github_stats.data.streak.count
  end

end
