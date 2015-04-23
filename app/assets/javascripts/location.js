/* global jQuery */
var Location = (function () {
  return {
      // Graciously borrowed from:
      //   http://stackoverflow.com/questions/27928/how-do-i-calculate-distance-between-two-latitude-longitude-points
      deg2rad: function(deg) { return deg * (Math.PI / 180); },
      getDistanceFromLatLonInKm: function(lat1, lon1, lat2, lon2) {
        var R = 6371; // Radius of the earth in km
        var dLat = this.deg2rad(lat2-lat1);  // deg2rad below
        var dLon = this.deg2rad(lon2-lon1);
        var a =
          Math.sin(dLat / 2) * Math.sin(dLat / 2) +
          Math.cos(this.deg2rad(lat1)) * Math.cos(this.deg2rad(lat2)) *
          Math.sin(dLon / 2) * Math.sin(dLon / 2);
        var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
        var d = R * c; // Distance in km
        return d;
      },

      toMiles: function(km) {
          return km * 0.621371;
      },

      getCohortPosition: function () {
          var coords = jQuery('#loc-data').data('location').split(',');
          this.cohort_lat = coords[0];
          this.cohort_long = coords[1];
      },


      getCurrentDistanceFromCohort: function(lat, long) {
          if (lat && long && this.cohort_long && this.cohort_lat) {
              this.distance = this.getDistanceFromLatLonInKm(lat, long, this.cohort_lat, this.cohort_long);
              console.debug('you are currently ', this.toMiles(this.distance), ' miles away from class');
          }
      },

      getCurrentPosition: function (callback) {
          var fallbackCallback = function (loc) {
              this.lat = loc.coords.latitude;
              this.long = loc.coords.longitude;
              this.getCurrentDistanceFromCohort(this.lat, this.long);
          }.bind(this);

          if (callback && callback.constructor && callback.call && callback.apply) {
            navigator.geolocation.getCurrentPosition(callback);
          } else {
            navigator.geolocation.getCurrentPosition(fallbackCallback);
          }
      }

  };
})();
