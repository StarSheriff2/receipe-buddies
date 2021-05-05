module UsersHelper
  def profile_picture(user, dimensions = [100, 100], gravity: :face, crop: :thumb, radius: nil, alt: nil, class_name: nil)
    if user.avatar.attached?
      cl_image_tag(user.avatar.key, :alt=>alt, :class=>class_name, :width=>dimensions[0], :height=>dimensions[1], :crop=>crop, :gravity => gravity, :radius=>radius, :fetch_format=>:auto)
    else
      image_tag('blank-profile-picture', class: class_name, size: dimensions[0].to_s, alt: alt)
    end
  end
end
