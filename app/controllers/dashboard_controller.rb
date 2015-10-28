class DashboardController < ApplicationController
  def show
    @response ||= GithubPresenter.new(current_user)
    @github_stats ||= GithubStatsGenerator.new(current_user)
  end
end
