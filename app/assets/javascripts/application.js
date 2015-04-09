//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require turbolinks
//= require react
//= require datetimepicker
//= require_tree .
//
//

var ready = function() {
  jQuery('.datetimepicker').datetimepicker();
};


jQuery(document).ready(ready);
jQuery(document).on('page:load', ready)

