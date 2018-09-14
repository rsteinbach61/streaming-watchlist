

$(document).ready(function() {
  attachListeners()
});

function attachListeners(){
  $('#search').on('click', function(){
    alert("Search");
  });

  $('#get_comments').on('click', displayComments);
}

function displayComments(){
  show = document.querySelector("#get_comments")
  $.get(`/shows/${show.dataset.show}/comments`, function(comments){
    comments.data.forEach(function(c){
      $("#comments").append(`<p onclick="getComment(${c.id})">${c.attributes.title}</p>`);
})})
}

function getComment(id){
  alert("get comment")
}
