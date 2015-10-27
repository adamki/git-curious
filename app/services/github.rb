class Github
  def initialize
    @connection = Hurley.new("http://api.github.com")
  end

  private

    def parse(response)
      JSON.parse(response).body
    end
end
