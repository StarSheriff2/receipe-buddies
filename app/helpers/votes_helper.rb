module VotesHelper
  def vote_button(opinion, path)
    if current_user.voted?(opinion)
      button = link_to vote_path(current_user.vote_record(opinion), path: path), method: 'DELETE' do
        content_tag(:i, '', class: %w[fas fa-thumbs-up])
      end
      text = content_tag(:span, 'You voted for this recipe!', class: 'primary-color-fonts ml-2')
    else
      button = link_to votes_path(vote: { opinion_id: opinion, user_id: current_user }, path: path), method: 'POST' do
        content_tag(:i, '', class: %w[far fa-thumbs-up])
      end
      text = content_tag(:span, 'Vote for this recipe', class: 'ml-2')
    end

    button + text
  end
end
