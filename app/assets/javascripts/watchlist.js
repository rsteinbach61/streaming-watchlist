

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
  //$("#games").empty();
  $.get(`/shows/${show.dataset.show}/comments`, function(comments){
    comments.data.forEach(function(c){
      $("#comments").append(`<button onclick="getComment(${c.id})">${c.attributes.title}</button><br>`);
})})
}

function getComment(id){
  alert("get comment")
}
