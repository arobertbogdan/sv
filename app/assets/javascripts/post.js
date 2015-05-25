/**
 * Created by smookygg on 18.05.2015.
 */
var ready;
ready = function() {
    setTimeout(function() {
        $(".alert").slideUp();
    }, 3000);

    var spans = $(".vote").find("span");
    spans.each(function(){
        if($(this).attr('vote_type') == "1"){
            $(this).css("color","green");
        }
        if($(this).attr('vote_type') == "-1"){
            $(this).css("color","red");
        }
    });

    $(".vote-up").on('click', function(){
        $.ajax({
            url: '/posts/' + this.getAttribute("post-id") + '/upvote',
            type: 'PUT'
        }).done(function (data){
            console.log(data)
        });
    });
    $(".vote-down").on('click', function(){
        $.ajax({
            url: '/posts/' + this.getAttribute("post-id") + '/downvote',
            type: 'PUT'
        }).done(function (data){
            console.log(data)
        });
    });

    var subscribe = $("#subscribe");
    var unsubscribe = $("#unsubscribe");

    subscribe.on('click', function(){
        $.ajax({
            url: '/category/' + this.getAttribute("category-id") + '/subscribe',
            type: 'POST'
        }).done(function (data){
            console.log(data);
            subscribe.hide();
            unsubscribe.show();
        });
    });
    unsubscribe.on('click', function(){
        $.ajax({
            url: '/category/' + this.getAttribute("category-id") + '/unsubscribe',
            type: 'POST'
        }).done(function (data){
            console.log(data);
            subscribe.show();
            unsubscribe.hide();
        });
    });
};

$(document).ready(ready);
$(document).on('page:load', ready);