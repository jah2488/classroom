/* global React, jQuery, Location */

var TooFar = React.createClass({
  getInitialState: function() {
    if (Location.distance === undefined || Location.distance === 0) {
        Location.getCurrentPosition(function (loc) {
          Location.getCurrentDistanceFromCohort(loc.coords.latitude, loc.coords.longitude);
          this.setState({ distance: Math.round(Location.toMiles(Location.distance) * 1000) / 1000 });
        }.bind(this));
    }
    return {
        distance: Location.distance
    };
  },
  handleChange: function(event) {
    this.setState({override_code: event.target.value.substr(0, 140)});
  },
  render: function () {
      var distance = 'You are ' + this.state.distance + ' miles away from campus.';
      if(this.state.distance > 1.0) {
          return (
              <div>
                <p className='muted'>{distance}</p>
                <div className="alert alert-info alert-dismissible" role="alert">
                  <button type="button" className="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                  </button>
                  You are too far from campus to check in without today's code. Please provide today's override code to check in.
                </div>
                <ErrorField error={this.state.error}/>
                <div className='form-group'>
                  <input type='text' onChange={this.handleChange} className='form-control' id='override_code' placeholder='Override Code' name='override_code' />
                </div>
              </div>
          );
      } else {
          return (<span/>);
      }
  }
});

var ErrorField = React.createClass({
    getInitialState: function() {
        return { visible: true };
    },
    dismiss: function() {
        this.setState({ visible: !this.state.visible });
    },
    render: function () {
        if(this.state.visible) {
            return (<div onClick={this.dismiss} className='errors'>{this.props.error}</div>);
        } else {
            return (<span onClick={this.dismiss} className='errors'>x</span>);
        }
    }
});

var Checkin = React.createClass({
    getInitialState: function() {
        if (Location.distance === undefined || Location.distance === 0) {
            Location.getCurrentPosition(function (loc) {
              Location.getCurrentDistanceFromCohort(loc.coords.latitude, loc.coords.longitude);
              this.setState({ distance: Math.round(Location.toMiles(Location.distance) * 1000) / 1000 });
            }.bind(this));
        } else {
          this.setState({ distance: Math.round(Location.toMiles(Location.distance) * 1000) / 1000 });
        }
        return {
            created_at: false,
            tardies: this.props.tardies,
            absences: this.props.absences,
            distance: null,
            override_code: null
        };
    },
    handleClick: function(event) {
        jQuery.ajax({
            method: 'POST',
            url: '/checkins',
            data: {
              override_code: this.state.override_code,
              distance: this.state.distance
            }
        }).done(function (response) {
            var createdAt = response[0];
            var checkin = response[1];
            var attendance = response[2];
            this.setState({
                created_at: createdAt,
                checkin: checkin,
                tardies: attendance.tardies,
                absences: attendance.absences
            });
        }.bind(this)).fail(function (response) {
            this.setState({error: response.responseText});
            jQuery('#override_code').val('').focus();
        }.bind(this));
    },
    render: function() {
        var status = this.state.checkin ? this.state.checkin.late ? 'LATE' : 'ONTIME' : '';
        var text = this.state.created_at ? 'CHECKED IN ' + status + ' AT ' + this.state.created_at : 'CHECK IN';
        var checkinButton;
        if (this.state.distance !== null) {
          checkinButton = (
              <div>
                 <TooFar/>
                 <ErrorField error={this.state.error} />
                 <a onClick={this.handleClick} className='btn btn-primary btn-lg full-width'>{text}</a>
              </div>
          );
        } else {
          text = 'Loading location...';
          checkinButton = (
             <a className='btn btn-primary btn-lg full-width'>{text}</a>
          );
        }
        return (
            <div>
                {checkinButton}
                <Attendance tardies={this.state.tardies} absences={this.state.absences}/>
            </div>
        );
    }
});
