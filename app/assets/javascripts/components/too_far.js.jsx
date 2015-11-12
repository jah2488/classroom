/* global React, jQuery, Location */
var TooFar = React.createClass({
        getInitialState: function() {
            return {distance: 0.0}
        },
        componentDidMount: function() {
                if (Location.distance === undefined || Location.distance === 0) {
                        Location.getCurrentPosition(function (loc) {
                                Location.getCurrentDistanceFromCohort(loc.coords.latitude, loc.coords.longitude);
                                this.setState({ distance: Math.round(Location.toMiles(Location.distance) * 1000) / 1000 });
                        }.bind(this));
                }
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
