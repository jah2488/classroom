/* global React, jQuery, Location */
var Checkin = React.createClass({
        getInitialState: function() {
                return {
                        distance: 0.0,// Location.distance // Disabling distance :(
                        checkinTime: this.props.checkinTime,
                        override_code: null,
                        loading: false
                };
        },
        componentDidMount: function() {
                if (Location.distance === undefined || Location.distance === 0) {
                        Location.getCurrentPosition(function (loc) {
                                Location.getCurrentDistanceFromCohort(loc.coords.latitude, loc.coords.longitude);
                                this.setState({ distance: Math.round(Location.toMiles(Location.distance) * 1000) / 1000 });
                        }.bind(this));
                } else {
                        this.setState({ distance: Math.round(Location.toMiles(Location.distance) * 1000) / 1000 });
                }

        },
        handleClick: function(event) {
                this.setState({loading: true})
                jQuery.ajax({
                        method: 'POST',
                        url: '/checkins',
                        data: {
                                override_code: this.state.override_code,
                                distance: this.state.distance
                        }
                }).done(response => {
                        var checkin = response[1];
                        var attendance = response[2];
                        this.setState({
                                checkinTime: checkin.created_at
                        });
                        this.props.onCheckin(checkin.created_at, attendance.tardies, attendance.absences);
                }).fail(response => {
                        this.setState({error: response.responseText});
                        jQuery('#override_code').val('').focus();
                }).always((response) => {
                        this.setState({loading: false})
                })
        },
        render: function() {
                if (this.state.checkinTime !== null) {
                        return (
                                <span/>
                        );
                } else if (this.state.distance !== null) {
                        return (
                                <div className="card-action">
                                        <TooFar/>
                                        <ErrorField error={this.state.error} />
                                        <a onClick={this.handleClick} disabled={!this.state.loading}>Check In</a>
                                </div>
                        );
                } else {
                        return (
                                <span>Loading location...</span>
                        );
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
