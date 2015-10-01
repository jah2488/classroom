var StudentEnroll = React.createClass({

  render: function() {
    return (
        <div>
          <UserLookup onSelect={this.userSelected}/>
          <CohortLookup onSelect={this.cohortSelected}/>
          <button className='btn btn-success' onClick={this.enroll}>Enroll</button>
        </div>
        );
  },

  userSelected: function(user) {
    this.setState({user: user});
  },

  cohortSelected: function(cohort) {
    this.setState({cohort: cohort});
  },

  enroll: function (e) {
    e.preventDefault();
    jQuery.ajax({
      method: 'POST',
      url: '/students',
      data: { student: { user_id: this.state.user.id, cohort_id: this.state.cohort.id } }
    }).done(function (response) {
      if (this.props.callback) {
        this.props.callback(response);
      }
      alert('enrolled');
    }.bind(this));
  }
});
