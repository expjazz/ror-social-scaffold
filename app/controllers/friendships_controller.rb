class FriendshipsController < ApplicationController
  def create
    current_user.requests_sent.create(passive_id: params[:user_id], status: false)
    redirect_to root_path
  end

  def update
    byebug
  end
end
