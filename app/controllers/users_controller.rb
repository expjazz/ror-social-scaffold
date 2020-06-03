class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @a = User.new
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.ordered_by_most_recent
    @friendship = Friendship.new
    @pending = current_user.friends(false)
  end

  def search
    @user_result = User.search(params[:user_search])
    @user = current_user
    @posts = @user.posts.ordered_by_most_recent
    @friendship = Friendship.new
    render 'users/show'
  end
end
