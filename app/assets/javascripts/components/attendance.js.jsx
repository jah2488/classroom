/* global React */

var Attendance = React.createClass({
  propTypes: {
    initialTardies: React.PropTypes.number,
    initialAbsences: React.PropTypes.number
  },
  getInitialState: function() {
    let checkin = null;
    if(this.props.status) {
      checkin = this.props.status.created_at;
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
    if(!this.props.notToday && this.state.checkinTime == null) {
      action = (
          <Checkin onCheckin={this.onCheckin} checkinTime={this.state.checkinTime}/>
      );
    }
    if(this.state.checkinTime != null) {
      today = (
        <p>Checked in <TimeField time={this.state.checkinTime} hoverable/></p>
      );
    }

    return (
        <div className="card blue darken-3">
          <div className="card-content white-text">
            <span className="card-title">Attendance</span>
              <p>
                <strong>Tardies:</strong> {this.state.tardies}
                &nbsp;
                <strong>Absences:</strong> {this.state.absences}
              </p>
              {{today}}
          </div>
          {{action}}
        </div>
        );
  }
});
