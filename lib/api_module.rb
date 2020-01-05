module ApiModule
  def self.get(url, params={})
    begin
      resource = RestClient::Resource.new(url, :timeout => 25, :open_timeout => 5)
      response = resource.get params
    rescue RestClient::ExceptionWithResponse => err
      Rails.logger.error("RestClient Get call failed\n #{err.response}")
      response = []
    end
    response
  end
end