class PullRequestDownloadsController < ApplicationController
  before_filter :ensure_logged_in

  def create
    Downloader.new(current_user).get_pull_requests
    pull_requests = current_user.pull_requests.year(current_year).order('created_at desc')

    render :create, :locals => { :pull_requests => pull_requests }, :layout => false
  end
end
