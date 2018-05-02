class Details

  def initialize(show, type)

    @show = show.gsub(" ","+")
    @type = type
  end

  def get_details
    response = RestClient::Request.execute( method: :get, url: 'http://www.omdbapi.com/?t=' + @show + '&type=' + @type + '&plot=full&apikey=a8a0eee0')
    JSON.parse(response)
  end

end
