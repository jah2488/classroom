/* global jQuery, Location */
//= require jquery
//= require jquery_ujs
//
//= require materialize-sprockets
//= require turbolinks
//
//= require refile
//= require datetimepicker
//= require clipboard
//
//= require react
//= require react_ujs
//= require components
//
//= require_tree .

var _loggedIn = false;

Location.distance = 0.1;

var ready = function() {
        $('.collapsible').collapsible({});
        $(".button-collapse").sideNav();
        $('select').material_select();
        jQuery('.datetimepicker').datetimepicker();

        new Clipboard('.clippy');

        if(_loggedIn && (Location.distance === undefined || Location.distance === 0)) {
                Location.getCohortPosition();
                Location.getCurrentPosition();
        }

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


jQuery(document).on('ready page:load page:change', ready);
