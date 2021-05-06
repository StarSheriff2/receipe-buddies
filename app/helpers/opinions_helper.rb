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

  def get_latest_opinions_count
    @timeline_opinions.created_after_last_logout(get_last_session_logout_date).count
  end
end
