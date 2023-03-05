$(function() {
    window.addEventListener('message', function(event) {
        var data = event.data;
        var sound = new Audio('sound.mp4');
        if (data.open === true) {
            $('body').show();
            sound.play();
        } else if (data.open === false) {
            $('body').hide();
        }
    })
})