class SearchController < ApplicationController
   def search
    #call github search service with search params
    public_respos = Github::SearchService.new(search_params, "repositories").perform
    @results = Kaminari.paginate_array(public_respos["data"], total_count: public_respos["total_count"]).page(params[:page]).per(30)
   end

   private

   def search_params
    params.permit(:search, :page)
   end
end