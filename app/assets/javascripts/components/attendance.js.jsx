/* global React */

var Attendance = React.createClass({
        propTypes: {
                initialTardies: React.PropTypes.number,
                initialAbsences: React.PropTypes.number
        },
        getInitialState: function() {
                let checkin = null;
                if(this.props.checkin) {
                        checkin = this.props.checkin.created_at;
                }
                return {
                        tardies: this.props.initialTardies,
                        absences: this.props.initialAbsences,
                        checkinTime: checkin
                };
        },
        onCheckin: function(time, tardies, absences) {
                this.setState({
                        checkinTime: time,
                        tardies: tardies,
                        absences: absences
                });
        },
        render: function() {
                let action;
                let today;

                return (
                                <div className="card grey darken-2">
                                <div className="card-content white-text">
                                <span className="card-title">Attendance</span>
                                <p>
                                <strong>Tardies:</strong> {this.state.tardies}
                                &nbsp;
                                <strong>Absences:</strong> {this.state.absences}
                                </p>
                                {this.renderToday()}
                                </div>
                                {this.renderActions()}
                                </div>
                       );
        },

        renderActions: function() {
                if(!this.props.notToday && this.state.checkinTime == null) {
                        return (
                                        <Checkin onCheckin={this.onCheckin} checkinTime={this.state.checkinTime}/>
                               );
                }
        },

        renderToday: function() {
                if(this.state.checkinTime != null) {
                        return (
                                        <p>Checked in <TimeField time={this.state.checkinTime} hoverable/></p>
                               );
                }
        }
});
