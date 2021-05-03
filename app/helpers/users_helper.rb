module UsersHelper
  def profile_picture(user, dimensions = [100, 100], crop = :thumb, border_type = nil)
    if user.avatar.attached?
      cl_image_tag user.avatar.key, :width=>dimensions[0], :height=>dimensions[1], :crop=>crop, :gravity => :face
    end
  end
end
