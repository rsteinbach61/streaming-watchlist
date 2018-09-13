

$(document).ready(function() {
  attachListeners()
});

function attachListeners(){
  $('#search').on('click', function(){
    alert("Search");
  });
}

function displayComments(){
  //$("#games").empty();
  $.get('/comments', function(comments){
    comments.data.forEach(function(c){
      $("#comments").append(`<button onclick="getComment(${c.id})">${c.title}</button><br>`);
})})
}

function getComment(){
  
}
