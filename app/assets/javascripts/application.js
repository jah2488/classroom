/* global jQuery, Location */
//= require jquery
//= require jquery_ujs
//
//= require bootstrap-sprockets
//= require turbolinks
//
//= require marked
//= require moment
//= require datetimepicker
//= require jquery-flot
//
//= require location
//= require react
//= require react_ujs
//= require components
//
//= require_tree .

var _loggedIn = false;

Location.distance = 0.1;

var ready = function() {
  jQuery('.datetimepicker').datetimepicker();
  $.material.init();


  if(_loggedIn && (Location.distance === undefined || Location.distance === 0)) {
      Location.getCohortPosition();
      Location.getCurrentPosition();
  }

  jQuery('textarea').on('keyup', function (e) {
    var elem = jQuery(this);
    elem.css('height', elem[0].scrollHeight);
  });

  jQuery('.fillLatLong').on('click', function (e) {
      if (Location.lat !== undefined && Location.long !== undefined) {
         jQuery('#cohort_latitude').val(Location.lat);
         jQuery('#cohort_longitude').val(Location.long);
      } else {
        navigator.geolocation.getCurrentPosition(function (loc) {
              Location.lat = loc.coords.latitude;
              Location.long = loc.coords.longitude;
              jQuery('#cohort_latitude').val(Location.lat);
              jQuery('#cohort_longitude').val(Location.long);
              jQuery(this).prop('disabled', true);
          }.bind(this));
      }
  });
};


jQuery(document).ready(ready);
jQuery(document).on('page:load', ready);

