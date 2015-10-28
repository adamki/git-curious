class GithubService
  attr_reader :connection, :user

  def initialize(user)
    @user = user
    @connection = Hurley::Client.new("https://api.github.com")
    connection.query[:access_token] = user.oauth_token
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

  def commits_in_last_year(user)
    find_user_repos(user).map do |repo|
      parse(connection.get("/repos/#{user.nickname}/#{repo[:name]}/stats/participation"))
    end
  end

  private

    def parse(response)
      JSON.parse(response.body, symbolize_names: true)
    end
end
