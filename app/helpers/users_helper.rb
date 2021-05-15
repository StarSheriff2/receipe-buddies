module UsersHelper
  def user_submit_btn_text
    logged_in? ? 'Save new updates' : 'Sign up'
  end

  def profile_picture_circle(user, dimensions, alt: nil, class_name: nil)
    if user.avatar.attached?
      cl_image_tag(user.avatar.key, width: dimensions, height: dimensions, alt: alt, class: class_name,
                                    crop: :fill, gravity: :face, radius: 'max', fetch_format: :auto)
    else
      image_tag('blank-profile-picture.png', class: class_name, width: dimensions, height: dimensions, alt: alt)
    end
  end

  def profile_picture_square(user, dimensions, alt: nil, class_name: nil)
    if user.avatar.attached?
      cl_image_tag(user.avatar.key, width: dimensions, height: dimensions,
                                    alt: alt, class: class_name,
                                    crop: :thumb, gravity: :face, fetch_format: :auto)
    else
      image_tag('blank-profile-picture.png', width: dimensions, height: dimensions, class: class_name,
                                         alt: alt)
    end
  end

  def cover_picture(user)
    return unless user.cover_image.attached?

    content_tag(:div, '', class: 'cover-picture-div',
                          style: "background: url(#{url_for(user.cover_image)}) center center/cover;")
  end

  def follow_button(user)
    if !current_user.following?(user) && current_user != user
      link_to followings_path(following: { follower_id: current_user, followed_id: user }), method: 'POST' do
        content_tag(:i, '', class: %w[fas fa-plus-circle])
      end
    elsif current_user == user
      nil
    else
      link_to following_path(current_user.following_record(user)), method: 'DELETE' do
        content_tag(:i, '', class: %w[fas fa-minus-circle])
      end
    end
  end

  def author_relationship_to_user(user)
    if current_user.following?(user)
      'THIS BUDDY'
    else
      current_user?(user) ? 'YOU' : 'THIS USER'
    end
  end

  def userpage_opinions_link(user)
    link_to content_tag(:i, '', class: %w[fas fa-list-ul]) unless current_user == user
  end

  def follow_button_small(user)
    return if current_user.following?(user)

    link_to followings_path(following: { follower_id: current_user, followed_id: user }), method: 'POST' do
      content_tag(:i, '', class: %w[fas fa-plus-circle])
    end
  end

  def follow_suggestions
    current_user.new_suggestions.ordered_by_most_recent
  end

  def homepage_opinions_profile_picture_link(opinion)
    link_to(profile_picture_square(opinion.author, 50, alt: 'author thumbnail picture',
                                                       class_name: 'opinion-author-thumb-pic mr-3 float-left'),
            user_path(opinion.author))
  end
end
