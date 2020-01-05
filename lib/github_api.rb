module GithubApi
  GITHUB_SEARCH_URL = "https://api.github.com/search".freeze
  def self.search_by_repositories(seach_query, page=1)
    url = "#{GITHUB_SEARCH_URL}/repositories?q=#{seach_query}&page=#{page}"
    res = ApiModule.get(url, {})
    if res.code != 200
      res = []
    else
      res = JSON.parse res
    end
    res
  end
end
