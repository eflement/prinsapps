$(document).ready(function () {

    $('#maandkalender').scrollTo('#tetonendag') ;


    $('#printknop').bind("click",function() {
        window.print();
        return false;});

    $('#printknop2').bind("click",function() {
        window.print();
        return false;});
});

