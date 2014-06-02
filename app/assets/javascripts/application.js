// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require turbolinks
//= require_tree .
function  bindMoreResults() {
    jQuery("span.more-results").unbind("click");
    jQuery("span.more-results").click(
        function(e){
            e.preventDefault();
            getMoreResults();
        });
}

function getMoreResults() {
    jQuery('span.more-results').hide();
    var page_value = parseInt(jQuery("form#filter #page").val()) + 1;
    jQuery("form#filter #page").val(page_value);
    var form = jQuery("form#filter");
    jQuery.getJSON(
        form.attr("action") + ".json",
        form.serialize(),
        appendData
    );
}

function appendData(data) {
    jQuery('span.more-results').show();
//parse the data and append it
}