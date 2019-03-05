class GitHubClient
  ROOT_ENDPOINT = 'https://api.github.com'.freeze

  def initialize(access_token)
    @http_client = setup_http_client
    @access_token = access_token
  end

  def create_gist(params)
    @http_client.post('gists') do |request|
      request.headers['Authorization'] = "token #{@access_token}"
      request.headers['Content-Type'] = 'application/json'
      request.body = params.to_json
    end
  end

  private

  def setup_http_client
    Faraday.new(url: ROOT_ENDPOINT)
  end

end
