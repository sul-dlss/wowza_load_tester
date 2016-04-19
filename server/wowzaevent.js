$(document).ready(function() {
    $("#load_time").text(new Date().getTime());

    $("#video_element").on( "play", function() {
        $("#play_time").text(new Date().getTime());
    });
});

