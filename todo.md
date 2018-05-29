DONE fix error when wrong password entered on sign in ** return head (:forbidden)

DONE scope method(s)

DONE fix sign up form DONE

DONE add genre to show

DONE add type of show (film or series)

DONE fix dropdown for watchlists when adding show, should only see lists for current user

DONE use OMDB API to do something cool
response = RestClient::Request.execute( method: :get, url: 'http://www.omdbapi.c
om/?t=blade+runner&plot=full&r=xml&apikey=')

JSON.parse(response) ["Title"]

DONE add user edit capability DONE

DONE add login required to all controllers DONE

DONE omniauth

DONE remove show_id from watchlists table

DONE scope method(s)
  find shows by genre or type or both

DONE nested resources

fix display on no watchlist errors

fix display on comments new

fix no display of WL on log in w/ Amazon

seed?
