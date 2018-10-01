

$(document).ready(function() {
  attachListeners()
});

function attachListeners(){
//document.getElementById("add_comment").onclick = function(){addComment()};

}

function addCommentForm(){

  let f = document.createElement("FORM");
  f.setAttribute("id", "dynamic_form");
  f.setAttribute("onSubmit", "addComment()")
  document.getElementById("form_div").appendChild(f);
  //document.body.appendChild(f);

  let title = document.createElement("INPUT");
  title.setAttribute("type", "text");
  //title.setAttribute("name", "comment_title");
  title.setAttribute("id", "cTitle");
  document.getElementById("dynamic_form").appendChild(title);

  let body = document.createElement("INPUT");
  body.setAttribute("type", "textarea");
  //body.setAttribute("name", "comment_body");
  body.setAttribute("id", "cBody");
  body.setAttribute("rows", "10");
  body.setAttribute("cols", "25");
  document.getElementById("dynamic_form").appendChild(body);

  let submit = document.createElement("INPUT");
  submit.setAttribute("type", "submit");
  //submit.setAttribute("value", "Submit");
  //submit.setAttribute("onclick", "test()");
  document.getElementById("dynamic_form").appendChild(submit);
}

function addComment(){
  event.preventDefault();
  var title = document.getElementById("cTitle").value
  var cBody = document.getElementById("cBody").value
  var data = {title: `${title}`, body: `${cBody}`}
  //somehow get the show ID
  show = document.querySelector("#next_comment");

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
      var ccc = new Comment(commentData[commentData.length - 1].title, commentData[commentData.length - 1].body, commentData[commentData.length - 1].id)
      ccc.otherComments();
    })
  }
//async function newaddComment(){
  //event.preventDefault();
  //var title = document.getElementById("cTitle").value
  //var cBody = document.getElementById("cBody").value
  //var data = {title: `${title}`, body: `${cBody}`}
  //somehow get the show ID
  //let show = document.querySelector("#next_comment");
  //onst settings = {
    //method: 'POST',
    //headers: {
        //Accept: 'application/json',
        //'Content-Type': 'application/json',
    //}
  //};

  //const fetchResult = await fetch(`/shows/${show.dataset.show}/comments.json`, settings);
  //.then(response => response.json())
  //.then(json => { return json;});
  //const response = await fetchResult;
  //const commentJson = await response.json();
  //alert(commentJson);
//}

async function nextComment(){
  let show = document.querySelector("#next_comment") // used to get the comment ID

    let myJson = fetchComments("#next_comment");
    myJson.then(function(nextComment){

      let index = nextComment.findIndex(key => key.id.toString() == show.dataset.comment) + 1; //looks for the index of the pair that matches the comments id

      if (index < nextComment.length){
        let newId = nextComment[index].id.toString();
        document.getElementById("comment_title").innerHTML = nextComment[index].title;
        document.getElementById("comment_body").innerHTML = nextComment[index].body;
        document.getElementById('next_comment').setAttribute('data-comment', `${newId}`);
      } else {
        alert("That's the last comment!");
      }
    })
  }

async function fetchComments(id){
  let show = document.querySelector(id);
  const url = `/shows/${show.dataset.show}/comments.json`;
  const fetchResult = fetch(url);
  const response = await fetchResult;
  const jsonData = await response.json();
  return jsonData;
}

async function fetchShow(id){
  const url = `/shows/${id}.json`;
  const fetchResult = fetch(url);
  const response = await fetchResult;
  const jsonData = await response.json();
  return jsonData;
}

function getComments(){
  let show = document.querySelector("#get_comments") // used to get the show ID
    let myJson = fetchComments("#get_comments");
      myJson.then(function(c){
        c.forEach(function(c){
        let li = document.createElement('li');
        let a = document.createElement('a');
        let text = document.createTextNode(`${c.title}`);
        a.appendChild(text);
        a.setAttribute('href',`/shows/${show.dataset.show}/comments/${c.id}`);
        li.appendChild(a);
        document.getElementById('comments').appendChild(li);

      });
    })
}
function Show(id, title, watchlist, genre, type, vote){
  this.id = id;
  this.title = title;
  this.watchlist = watchlist;
  this.genre = genre;
  this.type = type;
  this.vote = vote;
}

function vote(id){
  let x = fetchShow(id);
  x.then(function(s){

    let currentShow = new Show(s.id, s.show_title, s.watchlist_id, s.genre, s.show_type, s.vote);
    currentShow.upVote();
  })
}

Show.prototype.upVote = function(){
  //debugger;
  this.vote = (parseInt(this.vote) + 1).toString()
  let showData = postShow(this);

  alert(this.title);
}

function postShow(obj){

  fetch(`/shows/${obj.id}.json`,{
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
