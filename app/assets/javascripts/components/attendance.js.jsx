/* global React */

var Attendance = React.createClass({
  propTypes: {
    tardies: React.PropTypes.number,
    absences: React.PropTypes.number
  },

  render: function() {
    return (
      <div className='stats'>
        <span className='tardies'>Tardies: {this.props.tardies}</span>
        <span className='absences'>Absences: {this.props.absences}</span>
      </div>
    );
  }
});
