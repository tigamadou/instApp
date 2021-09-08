module PostsHelper
  def choose_new_or_edit
    if action_name == 'new'
      confirm_posts_path
    elsif action_name == 'create'
      confirm_posts_path
    elsif action_name == 'edit'
      post_path
    end
  end

  def author?(post)
    return true if current_user.id == post.user.id
  end
end
