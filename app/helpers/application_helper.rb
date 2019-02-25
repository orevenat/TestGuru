module ApplicationHelper
  def current_year
    Time.current.year
  end

  def github_url(author, repo = '')
    message = repo == '' ? author : repo
    link_to message, "https://github.com/#{author}/#{repo}", target: '_blank'
  end
end
