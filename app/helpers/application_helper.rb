module ApplicationHelper
  def current_year
    Time.current.year
  end

  def github_url(author, repo = '')
    "<a href='https://github.com/#{author}/#{repo}' target='_blank'>
      #{repo != '' ? repo : author}
    </a>".html_safe
  end
end
