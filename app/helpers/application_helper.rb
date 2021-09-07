module ApplicationHelper
    def like_or_dislike_btn(post)
        favorite = Favorite.find_by(post: post, user: current_user)
        if favorite
    
          link_to(favorite_path(
                        id: favorite.id,
                        post_id: post.id
                    ),
                    method: :delete,
                    class: 'btn rounded-circle  like liked') do
                        concat content_tag :span, nil, class: 'bi bi-heart ', title: 'Dislike'
                    end
    
        else
          link_to(favorites_path(post_id: post.id), method: :post, class: 'btn rounded-circle btn-light like') do
                concat content_tag :span, nil, class: 'bi bi-heart', title: 'Like'
                
            end
         end
    end

    def likes(post)
        "#{pluralize(post.favorites.count, 'like')}"
    end
end
