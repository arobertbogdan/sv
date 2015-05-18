/**
 * Created by smookygg on 18.05.2015.
 */
$(document).ready(function(){
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
});