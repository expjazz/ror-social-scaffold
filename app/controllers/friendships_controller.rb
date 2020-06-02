class FriendshipsController < ApplicationController
  def create
    current_user.requests_sent.create(passive_id: params[:user_id], status: false)
    redirect_to users_path
  end

  def update
    @friendship = Friendship.find(params[:id])
    @friendship.status = true
    @friendship.save
    redirect_to users_path
  end
end
