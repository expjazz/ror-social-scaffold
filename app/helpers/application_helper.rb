module ApplicationHelper
  def menu_link_to(link_text, link_path)
    class_name = current_page?(link_path) ? 'menu-item active' : 'menu-item'

    content_tag(:div, class: class_name) do
      link_to link_text, link_path
    end
  end

  def like_or_dislike_btn(post)
    like = Like.find_by(post: post, user: current_user)
    if like
      link_to('Dislike!', post_like_path(id: like.id, post_id: post.id), method: :delete)
    else
      link_to('Like!', post_likes_path(post_id: post.id), method: :post)
    end
  end

  def check_friendship(user, current_user)
    @friend = user
    @friendship = Friendship.find_by(active: current_user, passive: user) ||
                  Friendship.find_by(active: user, passive: current_user)
    friendship = @friendship
    return '' if current_user == @friend

    if friendship
      check_friend_status(friendship)
    else
      render 'users/send'
    end
  end

  def check_friend_status(friendship)
    if friendship.status != true && friendship.active == current_user
      render 'users/pending'
    elsif friendship.status == true
      render 'users/friends'
    elsif friendship.status != true && friendship.passive == current_user
      render 'users/friendconfirm', friendship: friendship
    end
  end

  def render_search(user)
    render 'users/search' if user == current_user
  end

  def render_username(user)
    render 'users/username', user: @user
  end

  def check_posts(post)
    if current_user.friends.include(post.user) || post.user == current_user
      post
    else
      return ''
    end
  end
end
