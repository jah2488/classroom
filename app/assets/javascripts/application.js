/* global jQuery, Location */
//= require jquery
//= require jquery_ujs
//
//= require bootstrap-sprockets
//= require turbolinks
//
//= require location
//= require react
//= require components
//= require react_ujs
//
//= require datetimepicker
//= require_tree .

var _loggedIn = false;

var ready = function() {
  jQuery('.datetimepicker').datetimepicker();


  if(_loggedIn && (Location.distance === undefined || Location.distance === 0)) {
      Location.getCohortPosition();
      Location.getCurrentPosition();
  }


  jQuery('.fillLatLong').on('click', function (e) {
      if (Location.lat === undefined || Location.long === undefined) {
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

