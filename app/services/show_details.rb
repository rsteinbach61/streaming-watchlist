class Details

  def initialize(show)

    @show = show.gsub(" ","+")
  end

  def get_details
    response = RestClient::Request.execute( method: :get, url: 'http://www.omdbapi.com/?t=' + @show + '&plot=full&apikey=a8a0eee0')
    JSON.parse(response)
  end

end
