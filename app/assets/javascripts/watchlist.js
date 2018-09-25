

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
      alert(commentData[0].title);
    })
  }


async function nextComment(){
  let show = document.querySelector("#next_comment") // used to get the comment ID
  //fetch(`/shows/${show.dataset.show}/comments.json`).then(function(response){
    //return response.json();})
    //.then(function(next_comment){

      const url = `/shows/${show.dataset.show}/comments.json`;
      const fetchResult = fetch(url);
      const response = await fetchResult;
      const nextComment = await response.json();

    let index = nextComment.findIndex(key => key.id.toString() == show.dataset.comment) + 1; //looks for the index of the pair that matches the comments id
    let newId = (index + 1).toString();
      if (index < nextComment.length){
        document.getElementById("comment_title").innerHTML = nextComment[index].title;
        document.getElementById("comment_body").innerHTML = nextComment[index].body;
        document.getElementById('next_comment').setAttribute('data-comment', `${newId}`);
      } else {
        alert("That's the last comment!");
      }
    //})
  }

//async function fetchComments(){
  //let show = document.querySelector("#get_comments");
  //const url = `/shows/${show.dataset.show}/comments.json`;
  //const fetchResult = fetch(url);
  //const response = await fetchResult;
  //const jsonData = await response.json();
  //return jsonData;
//}

function testgetComments(){
  let myJson = fetchComments();
  alert(myJson);
}

async function getComments(){
  let show = document.querySelector("#get_comments") // used to get the show ID
    const url = `/shows/${show.dataset.show}/comments.json`;
    const fetchResult = fetch(url);
    const response = await fetchResult;
    const myJson = await response.json();

      myJson.forEach(function(c){
        let a = document.createElement('a');
        let text = document.createTextNode(`${c.title}`);
        a.appendChild(text);
        a.setAttribute('href',`/shows/${show.dataset.show}/comments/${c.id}`);
        document.getElementById('comments').appendChild(a);
      });
    //});
}
