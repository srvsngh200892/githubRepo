class SearchControllerTest < ActionDispatch::IntegrationTest

  def test_search
    params = {
      search: 'acl',
      page: 1
    }
    # stub external api call
    GithubApi.expects(:search_by_repositories).with(params[:search], params[:page]).returns({"total_count"=>30, "items"=> [{"full_name"=> "acl", "html_url"=> "https://github.com/srvsngh200892/acl"}]})
    
    response = get search_page_url, params: params
    assert_response :success
  end
end