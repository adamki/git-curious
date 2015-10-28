class GithubPresenter
  attr_reader :user, :service

  def initialize(user)
    @user    ||= user
    @service ||= GithubService.new(user)
  end

  def repos
    repos = service.find_user_repos(user).map {|data| build_object(data)}
    repos.map {|repo| repo.name }
  end

  def followers
    followers = service.find_user_followers(user).map {|data| build_object(data)}
    followers.map {|follower| follower.login }
  end

  def commits_for_owned_repos
    commits = service.commits_in_last_year(user).reduce(0) do |sum, week|
      sum + week[:owner].reduce(:+)
    end
  end

  private

    def build_object(data)
      OpenStruct.new(data)
    end
end
