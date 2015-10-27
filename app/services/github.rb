class Github
  attr_reader :user, :connection

  def initialize(user)
    @user = user
    @connection = Hurley.new("http://api.github.com")
    @connection.query[:access_token] = user.oauth_token
  end

  private

    def parse(response)
      JSON.parse(response).body
    end
end
