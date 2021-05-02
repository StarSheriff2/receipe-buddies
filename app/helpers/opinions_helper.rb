module OpinionsHelper
  def calculate_time_ago(time_stamp)
    diff_in_min = (Time.now - time_stamp)/60

    case diff_in_min
    when 0...1
      "a minute ago"
    when 1...5
      "few minutes ago"
    when 5...60
      "#{diff_in_min} minutes ago"
    when 60...120
      "1 hour ago"
    when 120...1440
      "#{diff.div(60).to_i} hours ago"
    else
      "#{ time_stamp.to_date.strftime("%d %b") }"
    end

  end
end
