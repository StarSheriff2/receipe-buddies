module UsersHelper
  def profile_picture_circle(user, dimensions, alt: nil, class_name: nil)
    if user.avatar.attached?
      cl_image_tag(user.avatar.key, width: dimensions, height: dimensions, alt: alt, class: class_name,
                                    crop: :fill, gravity: :face, radius: "max", fetch_format: :auto)
    else
      image_tag('blank-profile-picture', class: class_name, width: dimensions, height: dimensions, alt: alt)
    end
  end

  def profile_picture_square(user, dimensions)
    if user.avatar.attached?
      cl_image_tag(user.avatar.key, width: dimensions, height: dimensions,
                                    alt: 'profile picture of logged user', class: 'left-menu-profile-pic',
                                    crop: :thumb, gravity: :face, fetch_format: :auto)
    else
      image_tag('blank-profile-picture', width: dimensions, height: dimensions, class: 'left-menu-profile-pic',
                                         alt: 'profile picture of logged user')
    end
  end

  def cover_picture(user)
    if user.cover_image.attached?
      content_tag(:div, "", class: "cover-picture-div", style: "background: url(#{ @user.cover_image.url }) center center/cover;")
    else
      return
    end
  end
end
