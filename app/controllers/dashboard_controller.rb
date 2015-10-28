class DashboardController < ApplicationController
  def show
    current_user
    @response ||= GithubPresenter.new(current_user)
  end
end
