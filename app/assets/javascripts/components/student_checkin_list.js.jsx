/* globals React */
var StudentCheckinList = React.createClass({
    getInitialState: function () {
      return { visible: false };
    },
    render: function () {
      if (this.state.visible) {
        return (
            <div>
              <p>Students in Attendance ({this.props.checkins.length}/{this.props.student_count}) <a onClick={this.handleClick} className='btn btn-xs btn-primary'>Hide</a></p>
                <ul className='list'>
                  {this.props.checkins.map(function (checkin, index) {
                      return (<li key={index}>
                          <p>{checkin.checkin_status} <a href='/students/{checkin.student.id}'>{checkin.student.name || checkin.student.email}</a></p>
                        </li>);
                  })}
                </ul>
            </div>
        );
      } else {
        return (
                <p>Students in Attendance ({this.props.checkins.length}/{this.props.student_count}) <a onClick={this.handleClick} className='btn btn-xs btn-primary'>Show</a></p>
        );
      }
    },

    handleClick: function () {
      this.setState({ visible: !this.state.visible });
    }
});
