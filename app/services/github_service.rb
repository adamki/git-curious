class GithubService
  attr_reader :connection, :user

  def initialize(user)
    @user = user
    @connection = Hurley::Client.new("https://api.github.com")
    connection.query[:access_token] = user.oauth_token
  end

  def find_user_followers(user)
    parse(connection.get("users/#{user.nickname}/followers"))
  end

  def find_user_repos(user)
    parse(connection.get("users/#{user.nickname}/repos"))
  end

  private

    def parse(response)
      JSON.parse(response.body, symbolize_names: true)
    end
end
