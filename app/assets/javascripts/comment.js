//---------------------- requirement 1 & 3 ----------------------
//comment.data.relationships.comments.data
function getComments(){
  document.getElementById('comments').innerHTML = "";
  const show = document.querySelector("#get_comments") // used to get the show ID
    const myJson = fetchShow(show.dataset.show); //calls fetch function with ID
      myJson.then(function(comment){
  
        if(comment.included){
          comment.included.forEach(function(comment){
            listComments(comment.attributes, comment.id);
          })
        }else{
          alert("There are no comments.")
        }

      });
}

function listComments(comment, showId){
  const show = document.querySelector("#get_comments") // used to get the show ID
    let li = document.createElement('li');
    let a = document.createElement('a');
    let text = document.createTextNode(`${comment.title}`);
    a.appendChild(text);
    a.setAttribute('href',`/shows/${show.dataset.show}/comments/${showId}`);
    li.appendChild(a);
    document.getElementById('comments').appendChild(li);
}

//---------------------- requirement 2 ----------------------
function nextComment(){
  let show = document.querySelector("#next_comment") // used to get the comment ID

    const myJson = fetchComments("#next_comment");
    myJson.then(function(nextComment){

      let index = nextComment.data.findIndex(key => key.id.toString() == show.dataset.comment) + 1; //looks for the index of the pair that matches the comments id
      if (index < nextComment.data.length){
        const newId = nextComment.data[index].id.toString();
        document.getElementById("comment_title").innerHTML = nextComment.data[index].attributes.title;
        document.getElementById("comment_body").innerHTML = nextComment.data[index].attributes.body;
        document.getElementById('next_comment').setAttribute('data-comment', `${newId}`);
      } else {
        alert("That's the last comment!");
      }
    })
  }
//---------------------- requirement 4 ----------------------

function addCommentForm(){
  const show = document.getElementsByClassName("add_comment")[0];
  const f = document.createElement("FORM");
  f.setAttribute("id", "dynamic_form");
  f.setAttribute("onSubmit", "addComment()");
  f.setAttribute("data-show", `${show.dataset.show}`);
  document.getElementsByClassName("form_div")[0].appendChild(f);

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
  const showId = document.getElementById("dynamic_form")
  const data = {title: `${title}`, body: `${cBody}`, show_id: `${showId.dataset.show}`}
  //somehow get the show ID
  const show = document.querySelector(".add_comment");

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
      const ccc = new Comment(commentData.data[commentData.data.length - 1].attributes.title, commentData.data[commentData.data.length - 1].attributes.body, commentData.data[commentData.data.length - 1].id, commentData.data[commentData.data.length - 1].attributes["show-id"])
      ccc.otherComments();
    })
  }
//commentData.data.forEach(function(comment){
//console.log(comment.attributes.title);})

//Comment object constructor
function Comment(title, body, id, show_id){
  this.title = title;
  this.body = body;
  this.id = id;
  this.show_id = show_id;
}
//Comment object protoype
Comment.prototype.otherComments = function(){

  alert(this.title + ' ' + this.body + ' ' + this.id + ' ' + this.show_id);
}
Comment.prototype.allComments = function(){

  const show = fetchShow(this.show_id);
  show.then(function(data){

    console.log(data.comments)
  })

}

// ---------------------- fetch functions ----------------------

async function fetchComment(commentsId, showId){
  //const show = document.querySelector(commentsId); //
  const url = `/shows/${showId}/comments/${commentsId}.json`; //sets the url for fetch using the ID from show

  //try {
  const fetchResult = fetch(url);
  const response = await fetchResult;
  const jsonData = await response.json();
//} catch(error){
//  let e = "fetchComments Error";
//  alert(e);
//}

  return jsonData;
}
async function fetchComments(commentsId){
  const show = document.querySelector(commentsId); //
  const url = `/shows/${show.dataset.show}/comments.json`; //sets the url for fetch using the ID from show

  //try {
  const fetchResult = fetch(url);
  const response = await fetchResult;
  const jsonData = await response.json();
//} catch(error){
//  let e = "fetchComments Error";
//  alert(e);
//}

  return jsonData;
}
