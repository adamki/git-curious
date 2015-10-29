class GithubService
  attr_reader :connection, :user

  def initialize(user)
    @user = user
    @connection = Hurley::Client.new("https://api.github.com")
    connection.query[:access_token] = user.oauth_token
  end

  def find_user(user)
    parse(connection.get("users/#{user}"))
  end

  def find_user_repos(user)
    parse(connection.get("users/#{user.nickname}/repos"))
  end

  def find_user_followers(user)
    parse(connection.get("users/#{user.nickname}/followers"))
  end

  def find_user_following(user)
    parse(connection.get("users/#{user.nickname}/following"))
  end

  def find_user_organizations(user)
    parse(connection.get("users/#{user.nickname}/orgs"))
  end

  def find_user_commits(user)
    repos = find_user_repos(user)
    repos_commits = repos.inject([])do |commits, repo|
      commits << parse(connection.get("repos/#{user.nickname}/#{repo[:name]}/commits"))
    end
  end

  private

    def parse(response)
      JSON.parse(response.body, symbolize_names: true)
    end
end
