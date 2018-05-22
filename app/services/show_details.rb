class Details

  def initialize(show, type)
    @show = show.gsub(" ","+")
    @type = type
  end

    # method will return the parsed detials from OMDB, called in the 
  def get_details
    # set var response to the reuslt of the API request using a URL built with variable from
    #the initialize method above and the OMDB key from .env
    response = RestClient::Request.execute( method: :get, url: 'http://www.omdbapi.com/?t=' + @show + '&type=' + @type + '&plot=full&apikey=' + ENV['OMDB_API_KEY'])
    # use the JSON parser to parse the data delivered into ver response
    JSON.parse(response)
  end
end
