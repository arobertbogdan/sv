/**
 * Created by smookygg on 18.05.2015.
 */
var ready;
ready = function() {
    $(".up_vote").on('click', function(){
        $.ajax({
            url: '/posts/' + this.getAttribute("post-id") + '/upvote',
            type: 'PUT'
        }).done(function (data){
            console.log(data)
        });
    });
    $(".down_vote").on('click', function(){
        $.ajax({
            url: '/posts/' + this.getAttribute("post-id") + '/downvote',
            type: 'PUT'
        }).done(function (data){
            console.log(data)
        });
    });
};

$(document).ready(ready);
$(document).on('page:load', ready);