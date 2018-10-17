
//---------------------- requirement 1 & 3 ----------------------
function getComments(){
  document.getElementById('comments').innerHTML = "";
  const show = document.querySelector("#get_comments") // used to get the show ID
    const myJson = fetchComments("#get_comments");
      myJson.then(function(comment){
        comment.forEach(function(comment){
        let li = document.createElement('li');
        let a = document.createElement('a');
        let text = document.createTextNode(`${comment.title}`);
        a.appendChild(text);
        a.setAttribute('href',`/shows/${show.dataset.show}/comments/${comment.id}`);
        li.appendChild(a);
        document.getElementById('comments').appendChild(li);
      });
    })
}

//---------------------- requirement 2 ----------------------
function nextComment(){
  let show = document.querySelector("#next_comment") // used to get the comment ID

    const myJson = fetchComments("#next_comment");
    myJson.then(function(nextComment){

      let index = nextComment.findIndex(key => key.id.toString() == show.dataset.comment) + 1; //looks for the index of the pair that matches the comments id

      if (index < nextComment.length){
        const newId = nextComment[index].id.toString();
        document.getElementById("comment_title").innerHTML = nextComment[index].title;
        document.getElementById("comment_body").innerHTML = nextComment[index].body;
        document.getElementById('next_comment').setAttribute('data-comment', `${newId}`);
      } else {
        alert("That's the last comment!");
      }
    })
  }
//---------------------- requirement 4 ----------------------

function addCommentForm(){

  const f = document.createElement("FORM");
  f.setAttribute("id", "dynamic_form");
  f.setAttribute("onSubmit", "addComment()")
  document.getElementById("form_div").appendChild(f);

  const title = document.createElement("INPUT");
  title.setAttribute("type", "text");
  title.setAttribute("id", "cTitle");
  document.getElementById("dynamic_form").appendChild(title);

  const body = document.createElement("INPUT");
  body.setAttribute("type", "textarea");
  body.setAttribute("id", "cBody");
  body.setAttribute("rows", "10");
  body.setAttribute("cols", "25");
  document.getElementById("dynamic_form").appendChild(body);

  const submit = document.createElement("INPUT");
  submit.setAttribute("type", "submit");
  document.getElementById("dynamic_form").appendChild(submit);
}

function addComment(){
  event.preventDefault();
  const title = document.getElementById("cTitle").value
  const cBody = document.getElementById("cBody").value
  const data = {title: `${title}`, body: `${cBody}`}
  //somehow get the show ID
  const show = document.querySelector("#next_comment");

  fetch(`/shows/${show.dataset.show}/comments.json`,{
    method: 'POST',
    //credentials: "same-origin",
    body: JSON.stringify(data),
    headers:{
      'Content-type': 'application/json'
    }
  }).then(function(response){

    return response.json();})
    .then(function(commentData){
      const ccc = new Comment(commentData[commentData.length - 1].title, commentData[commentData.length - 1].body, commentData[commentData.length - 1].id)
      ccc.otherComments();
    })
  }



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
//called from show view, kicks off upvote process
function vote(id){
  event.preventDefault();
  const show = fetchShow(id);
  show.then(function(showData){
    const currentShow = new Show(showData)
    currentShow.upVote();
  })
}
//object prototype
Show.prototype.upVote = function(){
  this.vote = (parseInt(this.vote) + 1).toString()
  const showData = postShow(this); //update the db
  showData.then(function(data){
    document.getElementById("votes").innerHTML = `Votes: ${data.vote}` //update vote count on show page.
  })
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

function Comment(title, body, id){
  this.title = title;
  this.body = body;
  this.id = id;
}

Comment.prototype.otherComments = function(){

  alert(this.title + ' ' + this.body + ' ' + this.id);
}

// ---------------------- fetch functions ----------------------
async function fetchComments(commentsId){
  const show = document.querySelector(commentsId);
  const url = `/shows/${show.dataset.show}/comments.json`;
  const fetchResult = fetch(url);
  const response = await fetchResult;
  const jsonData = await response.json();
  return jsonData;
}

async function fetchShow(showId){
  const url = `/shows/${showId}.json`;
  const fetchResult = fetch(url);
  const response = await fetchResult;
  const jsonData = await response.json();
  return jsonData;
}
