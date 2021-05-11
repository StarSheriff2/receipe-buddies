module OpinionsHelper
  def calculate_time_ago(time_stamp)
    diff_in_min = (Time.now - time_stamp) / 60

    case diff_in_min
    when 0...1
      'a min ago'
    when 1...5
      'few min ago'
    when 5...60
      "#{diff_in_min.to_i} min ago"
    when 60...120
      '1 hr ago'
    when 120...1440
      "#{(diff_in_min / 60).to_i} hr ago"
    else
      time_stamp.to_date.strftime('%d %b').to_s
    end
  end

  def timeline_opinions
    @timeline_opinions = current_user.own_and_others_opinions.ordered_by_most_recent.includes(:author)
  end

  def latest_opinions_count
    @timeline_opinions.where.not(author_id: current_user).created_after_last_logout(last_session_logout_date).count
  end

  def new_recipe_notification
    pluralize(latest_opinions_count, 'NEW RECIPE').upcase
  end
end
