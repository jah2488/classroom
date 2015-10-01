var StudentEnroll = React.createClass({
        getInitialState: function() {
                return {msg: ''};
        },
        render: function() {
                return (
                                <div>
                                <CohortLookup onSelect={this.cohortSelected}/>
                                <UserLookup onSelect={this.userSelected}/>
                                <button className='btn btn-success' onClick={this.enroll}>Enroll</button>
                                <span>{this.state.msg}</span>
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
                $.ajax({
                        method: 'POST',
                        url: '/students',
                        data: { student: { user_id: this.state.user.id, cohort_id: this.state.cohort.id } }
                }).done(function (response) {
                        if (this.props.callback) {
                                this.props.callback(response);
                        }
                        this.setState({msg: "Enrolled " + this.state.user.name});
                }.bind(this)).fail(function () {
                        this.setState({msg: "Failed"});
                });
        }
});
