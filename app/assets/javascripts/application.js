/* global jQuery */
//= require jquery
//= require jquery_ujs
//
//= require bootstrap-sprockets
//= require turbolinks
//
//= require react
//= require components
//= require react_ujs
//
//= require datetimepicker
//= require_tree .

var _loggedIn = false;
var _lat;
var _long;
var _cohort_lat;
var _cohort_long;
var _distance;

// Graciously borrowed from http://stackoverflow.com/questions/27928/how-do-i-calculate-distance-between-two-latitude-longitude-points
var deg2rad = function(deg) { return deg * (Math.PI / 180); };
var getDistanceFromLatLonInKm = function(lat1, lon1, lat2, lon2) {
  var R = 6371; // Radius of the earth in km
  var dLat = deg2rad(lat2-lat1);  // deg2rad below
  var dLon = deg2rad(lon2-lon1);
  var a =
    Math.sin(dLat / 2) * Math.sin(dLat / 2) +
    Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) *
    Math.sin(dLon / 2) * Math.sin(dLon / 2);
  var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
  var d = R * c; // Distance in km
  return d;
};

var toMiles = function(km) {
    return km * 0.621371;
};

var getCohortPosition = function () {
    var coords = jQuery('#loc-data').data('location').split(',');
    _cohort_lat = coords[0];
    _cohort_long = coords[1];
};


var getCurrentDistanceFromCohort = function() {
    if (_lat && _long && _cohort_long && _cohort_lat) {
        _distance = getDistanceFromLatLonInKm(_lat, _long, _cohort_lat, _cohort_long);
        console.debug('you are currently ', toMiles(_distance), ' miles away from class');
    }
};

var getCurrentPosition = function () {
    navigator.geolocation.getCurrentPosition(function (loc) {
        _lat = loc.coords.latitude;
        _long = loc.coords.longitude;
        getCurrentDistanceFromCohort();
    });
};



var ready = function() {
  jQuery('.datetimepicker').datetimepicker();


  if(_loggedIn) {
      getCohortPosition();
      getCurrentPosition();
  }


  jQuery('.fillLatLong').on('click', function (e) {
      if (_lat === undefined || _long === undefined) {
          navigator.geolocation.getCurrentPosition(function (loc) {
              _lat = loc.coords.latitude;
              _long = loc.coords.longitude;
              jQuery('#cohort_latitude').val(_lat);
              jQuery('#cohort_longitude').val(_long);
              jQuery(this).prop('disabled', true);
          }.bind(this));
      }
  });
};


jQuery(document).ready(ready);
jQuery(document).on('page:load', ready);

