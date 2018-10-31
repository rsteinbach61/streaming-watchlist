function showSearch(){
  event.preventDefault();
  document.getElementById("searchResult").innerHTML = "";
  const type = document.querySelector('input[name = "type"]:checked').value; //get the type and genre from the form
  const choice = document.getElementById("genres");
  const genre = choice.options[choice.selectedIndex].value;

  const shows = fetchShows();

  shows.then(function(programs){          //filter the results of the fetch by genre and type
    let genreFilter = programs.data.filter(g => g.attributes.genre === genre);
    let shows = genreFilter.filter(t => t.attributes["show-type"] === type);

    shows.forEach(function(show){           //display shows in the DOM
      let li = document.createElement('li');
      let a = document.createElement('a');
      let text = document.createTextNode(`${show.attributes["show-title"]}`);
      a.appendChild(text);
      a.setAttribute('href',`/shows/${show.id}`);
      li.appendChild(a);
      document.getElementById("searchResult").appendChild(li);
    })
  })
}

//function genre(genre, showGenre){
  //if (genre = showGenre){
    //return true;
  //}
  //return false;
//}
//---------------------- requirement 5 ----------------------
// Show Object constructor
function Show(showData){
  this.id = showData.id;
  this.title = showData.show_title;
  this.watchlist = showData.watchlist_id;
  this.genre = showData.genre;
  this.type = showData.show_type;
  this.vote = showData.vote;
}

//Show object prototype
Show.prototype.upVote = function(){
  this.vote = (parseInt(this.vote) + 1).toString()
  const showData = postShow(this); //update the db
  showData.then(function(data){
    document.getElementById("votes").innerHTML = `Votes: ${data.vote}` //update vote count on show page.
  })
}

//called from show view, kicks off upvote process
function vote(id){
  event.preventDefault();
  const show = fetchShow(id);
  show.then(function(showData){
    const currentShow = new Show(showData.data)
    currentShow.title = showData.data.attributes["show-title"];
    currentShow.type = showData.data.attributes["show-type"];
    currentShow.genre = showData.data.attributes["genre"];
    currentShow.watchlist = showData.data.attributes["watchlist-id"];
    currentShow.vote = showData.data.attributes["vote"];
    currentShow.upVote();
  })
      .catch(function(error){ //SHOULD IT GO HERE OR BELOW IN fetchShow?
        let e = "vote Error";
        alert(e);
      })
}

// ---------------------- fetch functions ----------------------

async function fetchShow(showId){
  const url = `/shows/${showId}.json`;
  //const url = `/bogus/${showId}.json`;
  //try {
    const fetchResult = fetch(url);
    const response = await fetchResult;
    const jsonData = await response.json();
  //} catch(error) {
  //  let e = "fetchShow Error";
  //  alert(e);
  //}
  return jsonData;
  //return json;
}

async function fetchShows(){
  const url = `/shows.json`;
  //const url = `/bogus/${showId}.json`;
  //try {
    const fetchResult = fetch(url);
    const response = await fetchResult;
    const jsonData = await response.json();
  //} catch(error) {
  //  let e = "fetchShow Error";
  //  alert(e);
  //}
  return jsonData;
  //return json;
}

//update the db with edits to show
function postShow(obj){
  return fetch(`/shows/${obj.id}.json`,{
            method: 'PATCH',
            body: JSON.stringify(obj),
            headers:{
              'Content-type': 'application/json'
            }
          }).then(function(response){
              return response.json();})
              .then(function(showData){
              return showData;
            })
}
let watchlistId;

function sortShows(event){
  watchlistId = event.target.dataset.list;
  const list = fetchShows();

  list.then(function(shows){
    const showList = shows.data.filter(s => s.attributes["watchlist-id"] === parseInt(watchlistId))
    showList.sort(function(a,b){
      let showA = a.attributes["show-title"];
      let showB = b.attributes["show-title"];
      if (showA < showB) {
        return -1;
      }
      if (showA > showB) {
        return 1;
      }
      return 0;
     })
     debugger;
     showList.forEach(function(show){           //display shows in the DOM
       let li = document.createElement('li');
       let a = document.createElement('a');
       let text = document.createTextNode(`Show: ${show.attributes["show-title"]},  Genre: ${show.attributes["genre"]}, Type: ${show.attributes["show-type"]}`);
       a.appendChild(text);
       a.setAttribute('href',`/shows/${show.id}`);
       li.appendChild(a);
       document.getElementById("watchlistSort").appendChild(li);
     })

  })

}
