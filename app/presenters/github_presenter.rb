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

  def following
    following = service.find_user_following(user).map {|data| build_object(data)}
    following.map {|followed_user| followed_user.login }
  end

  def organizations
    organizations = service.find_user_organizations(user).map {|data| build_object(data)}
    organizations.map{ |organization| organization.login}
  end

  def commits
    commits = service.find_user_commits(user).flatten
  end

  def image(user)
    user = service.find_user(user)
    user[:avatar_url]
  end


  private
    def build_object(data)
      OpenStruct.new(data)
    end
end
