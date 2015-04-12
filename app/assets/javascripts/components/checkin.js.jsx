/* global React, jQuery, _distance */

var Checkin = React.createClass({
    getInitialState: function() {
        return {
            created_at: false,
            tardies: this.props.tardies,
            absences: this.props.absences
        };
    },
    handleClick: function(event) {
        jQuery.ajax({
            method: 'POST',
            url: '/checkins'
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
            this.setState({error: response});
        }.bind(this));
    },
    dismiss: function() {
        this.setState({error: null});
    },
    render: function() {
        var status = this.state.checkin ? this.state.checkin.late ? 'LATE' : 'ONTIME' : '';
        var text = this.state.created_at ? 'CHECKED IN ' + status + ' AT ' + this.state.created_at : 'CHECKIN';
        if(_distance > 1.0) {
            return (
                <div>
                    <span onClick={this.dismiss} className='errors'>You are too far from campus to checkin.</span>
                    <a className='btn btn-primary btn-lg full-width'>CANNOT CHECKIN</a>
                </div>
            );
        }
        return (
            <div>
                <span onClick={this.dismiss} className='errors'>{this.state.error}</span>
                <a onClick={this.handleClick} className='btn btn-primary btn-lg full-width'>{text}</a>

                <Attendance tardies={this.state.tardies} absences={this.state.absences}/>
            </div>
        );
    }
});
