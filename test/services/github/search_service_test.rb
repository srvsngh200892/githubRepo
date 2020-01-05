require 'test_helper'

class Github::SearchServiceTest < ActiveSupport::TestCase
  test 'it should return empty result' do
    params = {
      search: "",
      page: 1
    }
    response = Github::SearchService.new(params, 'repositories').perform
    assert_equal 0, response['total_count']
    assert_equal [], response['data']
  end

  test 'it should return search result' do
    params = {
      search: 'acl',
      page: 1
    }

    # stub external api call
    GithubApi.expects(:search_by_repositories).with(params[:search], params[:page]).returns({"total_count"=>30, "items"=> [{"full_name"=> "acl", "html_url"=> "https://github.com/srvsngh200892/acl"}]})
    
    response = Github::SearchService.new(params, 'repositories').perform
    
    assert_equal 30, response['total_count']
  end
end