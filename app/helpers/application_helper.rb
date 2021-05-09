module ApplicationHelper
  def active_link_home
    class_names(left_menu_link_active: current_page?(root_path) || current_page?(opinions_path))
  end

  def active_link_current_user
    class_names(left_menu_link_active: current_page?(user_path(current_user)))
  end
end
