module UsersHelper
  def user_submit_btn_text
    current_page?(new_user_path) ? 'Sign up' : 'Save new updates'
  end

  def profile_picture_circle(user, dimensions, alt: nil, class_name: nil)
    if user.avatar.attached?
      cl_image_tag(user.avatar.key, width: dimensions, height: dimensions, alt: alt, class: class_name,
                                    crop: :fill, gravity: :face, radius: 'max', fetch_format: :auto)
    else
      image_tag('blank-profile-picture', class: class_name, width: dimensions, height: dimensions, alt: alt)
    end
  end

  def profile_picture_square(user, dimensions, alt: nil, class_name: nil)
    if user.avatar.attached?
      cl_image_tag(user.avatar.key, width: dimensions, height: dimensions,
                                    alt: alt, class: class_name,
                                    crop: :thumb, gravity: :face, fetch_format: :auto)
    else
      image_tag('blank-profile-picture', width: dimensions, height: dimensions, class: class_name,
                                         alt: alt)
    end
  end

  def cover_picture(user)
    return unless user.cover_image.attached?

    content_tag(:div, '', class: 'cover-picture-div',
                          style: "background: url(#{@user.cover_image.url}) center center/cover;")
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
end
