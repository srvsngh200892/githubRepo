class Github::SearchService
  attr_reader :seach_query
  attr_reader :category
  attr_reader :page

  def initialize(params, category)

	@seach_query = params[:search] ? params[:search].downcase : ''
	@page = params[:page].to_i
    @category = category.downcase
  end

  def perform
	data = []
	total_count = 0
	if seach_query.present?
	    # call github serch api to get public repo by passing search query and page
		begin
		  Rails.logger.info("call github api for getting #{category}")
	   	  response = ::GithubApi.send "search_by_#{category}", seach_query, page
	   	rescue => e
	   	  Rails.logger.error("error while calling github api for #{category} #{e}")
	   	   	response = []
	   	   end
		   items = response.count>0 && response["items"]  ? response["items"] : []
		   items.each do |item|
		    	data.push({"name"=> item["full_name"], "html_url" => item["html_url"]})
		   end
		   total_count = response['total_count'].to_i > 1000 ? 1000 :  response['total_count'].to_i
		end
	   return {"total_count"=>total_count, "data"=>data}
	end
end


