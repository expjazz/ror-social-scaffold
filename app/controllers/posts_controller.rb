class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @post = Post.new
    timeline_posts
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to posts_path, notice: 'Post was successfully created.'
    else
      timeline_posts
      render :index, alert: 'Post was not created.'
    end
  end

  private

  def timeline_posts
    @timeline_posts ||= Post.all.ordered_by_most_recent.includes(:user)
    @timeline_posts = friends_posts(@timeline_posts)
  end

  def post_params
    params.require(:post).permit(:content)
  end

  def friends_posts(timeline)
    timeline.select { |p| p.check_posts(current_user) }
  end

  def returned_posts
    return @friends_posts = friends_posts if friends_posts

    timeline_posts
  end
end
