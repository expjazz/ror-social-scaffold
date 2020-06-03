class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @a = User.new
  end

  def show
    if @id
      @user = User.find(@id)
    else
      @user = User.find(params[:id])
    end
    @posts = @user.posts.ordered_by_most_recent
    @friendship = Friendship.new
  end

  def search
    @id = current_user.id
    @user_result = User.search(params[:user_search])
    if @id
      @user = User.find(@id)
    else
      @user = User.find(params[:id])
    end
    @posts = @user.posts.ordered_by_most_recent
    @friendship = Friendship.new
    render 'users/show'
  end

end
